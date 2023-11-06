codeunit 50010 SalesPost
{
    var
        SalesPostVar: Codeunit 50010;
        WHTManagement: Codeunit WHTManagement;
        TempSalesLine: Record "Sales Line" temporary;
        GLSetup: Record "General Ledger Setup";
        GLEntry: Record "G/L Entry";
        TempSalesLineGlobal: Record "Sales Line" temporary;
        GenJnlPostLine: Codeunit GenJnlPostLine;//"Gen. Jnl.-Post Line";
        GenJnlPostLine1: Codeunit 12;
        GenJnlLineDocType: Enum "Gen. Journal Document Type";
        GenJnlLineDocNo: Code[20];
        CurrExchRate: Record "Currency Exchange Rate";
        GenJnlLineExtDocNo: Code[35];
        Text28000: Label 'You are not allowed to use payment method code when Manual Sales WHT Calc. is checked in General Ledger Setup.';


    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterCheckAndUpdate', '', false, false)]
    Procedure OnAfterCheckAndUpdate(VAR SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    begin
        // Message('chechwhtapplication');
        CheckWHTApplication(SalesHeader);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostGLAndCustomer', '', false, false)]
    //local procedure OnBeforePostInvoice(var SalesHeader: Record "Sales Header"; var CustLedgerEntry: Record "Cust. Ledger Entry"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean)
    local procedure OnBeforePostGLAndCustomer(var SalesHeader: Record "Sales Header"; var TempInvoicePostBuffer: Record "Invoice Post. Buffer" temporary; var CustLedgerEntry: Record "Cust. Ledger Entry"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean)

    var
        d: Codeunit "Sales-Post";
        TotalAmount: Decimal;
    begin


    end;

    procedure PostWHT(var SalesHeader: Record "Sales Header"; TotalInvAmount: Decimal; TempSalesLineGlobal: Record "Sales Line"; SalesInvHeader: Record 112)
    var
        GenJnlLine: Record "Gen. Journal Line";
        GLReg: Record "G/L Register";
        WHTPostingSetup: Record "WHT Posting Setup";
        WHTEntry: Record "WHT Entry";
        //  SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: record "Sales Cr.Memo Header";
    begin
        // Message('%1..%2', TempSalesLineGlobal."WHT Business Posting Group", TempSalesLineGlobal."WHT Product Posting Group");
        with SalesHeader do begin
            WHTPostingSetup.Get(TempSalesLineGlobal."WHT Business Posting Group", TempSalesLineGlobal."WHT Product Posting Group");
            if "Document Type" in ["Document Type"::Order, "Document Type"::Invoice] then begin
                if TotalInvAmount >= WHTPostingSetup."WHT Minimum Invoice Amount" then
                    WHTManagement.InsertCustInvoiceWHT(SalesInvHeader);
                WHTEntry.Reset();
                WHTEntry.SetRange("Document Type", WHTEntry."Document Type"::Invoice);
                WHTEntry.SetRange("Document No.", SalesInvHeader."No.");
                if WHTEntry.Find('-') then
                    repeat
                        WHTPostingSetup.Get(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                        if (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::Payment) and
                           (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::" ")
                        then
                            if WHTEntry.Amount <> 0 then begin
                                // SalesHeader."WHT Amount" := SalesHeader."WHT Avendormount" + WHTEntry.Amount;
                                InsertGenJournalWHT(SalesHeader, SalesInvHeader, GenJnlLine, WHTPostingSetup.GetPrepaidWHTAccount, -WHTEntry.Amount);
                                GenJnlPostLine.IncreaseWHTEntryNo;
                                GenJnlPostLine1.RunWithCheck(GenJnlLine);
                            end;
                    until WHTEntry.Next() = 0;

                if WHTEntry.Find('+') then
                    if GLReg.FindLast() then begin
                        GLReg."To WHT Entry No." := WHTEntry."Entry No.";
                        GLReg.Modify();
                    end;
            end else begin
                WHTManagement.InsertCustCreditWHT(SalesCrMemoHeader, "Applies-to ID");
                WHTEntry.Reset();
                WHTEntry.SetRange("Document Type", WHTEntry."Document Type"::"Credit Memo");
                WHTEntry.SetRange("Document No.", SalesCrMemoHeader."No.");
                if WHTEntry.Find('-') then
                    repeat
                        WHTPostingSetup.Get(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                        if (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::Payment) and
                           (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::" ")
                        then
                            if WHTEntry.Amount <> 0 then begin
                                //SalesHeader."WHT Amount" := SalesHeader."WHT Amount" + WHTEntry.Amount;
                                InsertGenJournalWHT(SalesHeader, SalesInvHeader, GenJnlLine, WHTPostingSetup.GetPrepaidWHTAccount, -WHTEntry.Amount);
                                GenJnlPostLine.IncreaseWHTEntryNo;
                                GenJnlPostLine1.RunWithCheck(GenJnlLine);
                            end;
                    until WHTEntry.Next() = 0;

                if WHTEntry.Find('+') then
                    if GLReg.FindLast() then begin
                        GLReg."To WHT Entry No." := WHTEntry."Entry No.";
                        GLReg.Modify();
                    end;
            end;
        end;

        // if (SalesHeader."WHT Amount" <> 0) then
        //    WHTManagement.PrintWHTSlips(GLReg, false);
    end;


    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostBalancingEntry', '', false, false)]
    procedure OnBeforePostBalancingEntry(VAR GenJnlLine: Record "Gen. Journal Line";
    SalesHeader: Record "Sales Header"; VAR TotalSalesLine: Record "Sales Line";
    VAR TotalSalesLineLCY: Record "Sales Line"; CommitIsSuppressed: Boolean)
    var

        Text28000: label 'You are not allowed to use payment method code when Manual Sales WHT Calc. is checked in General Ledger Setup.';
        GLSetup: Record "General Ledger Setup";
        TotalSalesLine2: Record "Sales Line";
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
        TempSalesLineGlobal: Record "Sales Line";
    begin

        //>>PRU_RPG WHT_0.1
        IF GLSetup."Manual Sales WHT Calc." THEN
            ERROR(Text28000);


        GenJnlLine."WHT Business Posting Group" := TempSalesLineGlobal."WHT Business Posting Group";
        GenJnlLine."WHT Product Posting Group" := TempSalesLineGlobal."WHT Product Posting Group";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostCustomerEntry', '', true, true)]
    local procedure "Sales-Post_OnBeforePostCustomerEntry"
  (
      var GenJnlLine: Record "Gen. Journal Line";
      var SalesHeader: Record "Sales Header";
      var TotalSalesLine: Record "Sales Line";
      var TotalSalesLineLCY: Record "Sales Line";
      CommitIsSuppressed: Boolean;
      PreviewMode: Boolean;
      var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"
  )
    var
        GLSetup: Record "General Ledger Setup";
    begin


        GenJnlLine."WHT Business Posting Group" := TempSalesLineGlobal."WHT Business Posting Group";
        GenJnlLine."WHT Product Posting Group" := TempSalesLineGlobal."WHT Product Posting Group";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLines', '', true, true)]
    local procedure "Sales-Post_OnAfterPostSalesLines"
    (
        var SalesHeader: Record "Sales Header";
        var SalesShipmentHeader: Record "Sales Shipment Header";
        var SalesInvoiceHeader: Record "Sales Invoice Header";
        var SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        var ReturnReceiptHeader: Record "Return Receipt Header";
        WhseShip: Boolean;
        WhseReceive: Boolean;
        var SalesLinesProcessed: Boolean;
        CommitIsSuppressed: Boolean;
        EverythingInvoiced: Boolean;
        var TempSalesLineGlobal: Record "Sales Line"
    )
    begin
        SalesHeader.CalcFields(Amount);
        //  Message('%1', SalesHeader.Amount);
        //  Message('%1..%2..%3', TempSalesLineGlobal."No.", TempSalesLineGlobal."WHT Business Posting Group", TempSalesLineGlobal."WHT Product Posting Group");
        GLSetup.Get();
        if GLSetup."Enable WHT" then //and (not GLSetup."Enable GST (Australia)")
            PostWHT(SalesHeader, SalesHeader.Amount, TempSalesLineGlobal, SalesInvoiceHeader);
    end;


    ///
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostBalancingEntryOnAfterInitNewLine', '', false, false)]
    local Procedure OnPostBalancingEntryOnAfterInitNewLine(SalesHeader: Record "Sales Header"; var GenJnlLine: Record "Gen. Journal Line")
    begin
        GenJnlLine."WHT Business Posting Group" := TempSalesLineGlobal."WHT Business Posting Group";
        GenJnlLine."WHT Product Posting Group" := TempSalesLineGlobal."WHT Product Posting Group";
    end;
    ////



    /*
        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertPostedHeadersOnBeforeInsertInvoiceHeader', '', false, false)]
        local procedure OnInsertPostedHeadersOnBeforeInsertInvoiceHeader(SalesHeader: Record "Sales Header"; var IsHandled: Boolean; SalesInvHeader: Record "Sales Invoice Header"; var GenJnlLineDocType: Enum "Gen. Journal Document Type"; var GenJnlLineDocNo: Code[20]; var GenJnlLineExtDocNo: Code[35])
        var
            GenJnlLine: Record "Gen. Journal Line";
            SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        begin
            if SalesHeader.Invoice then begin
                if SalesHeader."Document Type" in [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice] then begin
                    GenJnlLineDocType := GenJnlLine."Document Type"::Invoice;
                    GenJnlLineDocNo := SalesInvHeader."No.";
                    GenJnlLineExtDocNo := SalesInvHeader."External Document No.";
                end else begin // Credit Memo
                    GenJnlLineDocType := GenJnlLine."Document Type"::"Credit Memo";
                    GenJnlLineDocNo := SalesCrMemoHeader."No.";
                    GenJnlLineExtDocNo := SalesCrMemoHeader."External Document No.";
                end;
            end;
        end;
    */



    procedure InsertGenJournalWHT(var SalesHeader: Record "Sales Header"; SalesInvHeader: record 112; var GenJnlLine: Record "Gen. Journal Line"; AccountNo: Code[20]; AmountWHT: Decimal)
    begin
        with GenJnlLine do begin
            Init();
            "Posting Date" := SalesHeader."Posting Date";
            "Document Date" := SalesHeader."Document Date";
            Description := SalesHeader."Posting Description";
            "Shortcut Dimension 1 Code" := SalesHeader."Shortcut Dimension 1 Code";
            "Shortcut Dimension 2 Code" := SalesHeader."Shortcut Dimension 2 Code";
            "Dimension Set ID" := SalesHeader."Dimension Set ID";
            "Reason Code" := SalesHeader."Reason Code";
            "Account Type" := "Account Type"::"G/L Account";
            "Account No." := AccountNo;
            "Document Type" := "Document Type"::Invoice;
            "Document No." := SalesInvHeader."No.";
            "External Document No." := GenJnlLineExtDocNo;
            "Currency Code" := SalesHeader."Currency Code";
            Amount := AmountWHT;
            "Source Currency Code" := SalesHeader."Currency Code";
            "Source Currency Amount" := AmountWHT;
            if SalesHeader."Currency Code" <> '' then
                "Amount (LCY)" :=
                  Round(
                    CurrExchRate.ExchangeAmtFCYToLCY(
                      SalesHeader."Posting Date", SalesHeader."Currency Code", AmountWHT, SalesHeader."Currency Factor"));
            if SalesHeader."Currency Code" = '' then
                "Currency Factor" := 1
            else
                "Currency Factor" := SalesHeader."Currency Factor";
            //// "Sales/Purch. (LCY)" := -TotalSalesLineLCY.Amount;
            Correction := SalesHeader.Correction;
            // "Inv. Discount (LCY)" := -TotalSalesLineLCY."Inv. Discount Amount";
            "Sell-to/Buy-from No." := SalesHeader."Sell-to Customer No.";
            "Bill-to/Pay-to No." := SalesHeader."Bill-to Customer No.";
            "System-Created Entry" := true;
            "On Hold" := SalesHeader."On Hold";
            "Allow Application" := SalesHeader."Bal. Account No." = '';
            "Due Date" := SalesHeader."Due Date";
            "Payment Terms Code" := SalesHeader."Payment Terms Code";
            "Source Type" := "Source Type"::Vendor;
            "Source No." := SalesHeader."Bill-to Customer No.";
            // "Source Code" := SrcCode;
            "Posting No. Series" := SalesHeader."Posting No. Series";
            "IC Partner Code" := SalesHeader."Sell-to IC Partner Code";
            //  Adjustment := SalesHeader.Adjustment;
            //  "BAS Adjustment" := SalesHeader."BAS Adjustment";
            //  "Adjustment Applies-to" := SalesHeader."Adjustment Applies-to";
            // Message('%1', "Source No.");
        end;
    end;


    procedure CheckWHTApplication(SalesHeader: Record "Sales Header")
    begin
        with SalesHeader do begin
            if IsCreditDocType() then begin
                if ("Applies-to Doc. Type" = "Applies-to Doc. Type"::Invoice) and ("Applies-to Doc. No." <> '') then
                    WHTManagement.CheckApplicationSalesWHT(SalesHeader);
                if (("Applies-to Doc. Type" = "Applies-to Doc. Type"::Refund) and ("Applies-to Doc. No." <> '')) or
                   ("Applies-to ID" <> '')
                then
                    WHTManagement.CheckApplicationSalesWHT(SalesHeader);
            end;
            //  Message('chechwhtapplication...');
            if "Document Type" in ["Document Type"::Invoice] then begin
                if ("Applies-to Doc. Type" = "Applies-to Doc. Type"::"Credit Memo") and ("Applies-to Doc. No." <> '') then
                    WHTManagement.CheckApplicationSalesWHT(SalesHeader);

                if (("Applies-to Doc. Type" = "Applies-to Doc. Type"::Payment) and ("Applies-to Doc. No." <> '')) or
                   ("Applies-to ID" <> '')
                then
                    WHTManagement.CheckApplicationSalesWHT(SalesHeader);
            end;
        end;
    end;

}