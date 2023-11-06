codeunit 50001 PurchPost
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnCreatePurchHeaderOnBeforePurchOrderHeaderModify', '', true, true)]
    local procedure "Purch.-Quote to Order_OnCreatePurchHeaderOnBeforePurchOrderHeaderModify"
    (
        var PurchOrderHeader: Record "Purchase Header";
        var PurchHeader: Record "Purchase Header"
    )
    begin
        PurchOrderHeader."Requisition Slip No." := PurchHeader."Requisition Slip No.";
        PurchOrderHeader."Reference No." := PurchHeader."Reference No.";
        PurchOrderHeader."Purchase Type" := PurchHeader."Purchase Type";
    end;



    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure "Vendor Ledger Entry_OnAfterCopyVendLedgerEntryFromGenJnlLine"
     (
         var VendorLedgerEntry: Record "Vendor Ledger Entry";
         GenJournalLine: Record "Gen. Journal Line"
     )
    begin
        VendorLedgerEntry."Vendor Type" := GenJournalLine."Vendor Type"; //PruRaj
        //VendorLedgerEntry."Line Narration1" := GenJournalLine."Line Narration1";//PRU_NEELESH
    END;



    //////WHT CODES
    var
        PurcPostVar: Codeunit 50001;
        WHTManagement: Codeunit WHTManagement;
        TempPurchLine: Record "Purchase Line" temporary;
        GLSetup: Record "General Ledger Setup";
        GLEntry: Record "G/L Entry";
        TempPurchLineGlobal: Record "Purchase Line" temporary;
        GenJnlPostLine: Codeunit GenJnlPostLine;//"Gen. Jnl.-Post Line";
        GenJnlPostLine1: Codeunit 12;
        GenJnlLineDocType: Enum "Gen. Journal Document Type";
        GenJnlLineDocNo: Code[20];
        CurrExchRate: Record "Currency Exchange Rate";
        GenJnlLineExtDocNo: Code[35];
        Text28000: Label 'You are not allowed to use payment method code when Manual Sales WHT Calc. is checked in General Ledger Setup.';

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterCheckPurchDoc', '', false, false)]
    Procedure OnAfterCheckPurchDoc(VAR PurchHeader: Record "Purchase Header"; PreviewMode: Boolean)
    begin
        // Message('chechwhtapplication');
        CheckWHTApplication(PurchHeader);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostGLAndVendor', '', false, false)]
    //local procedure OnBeforePostInvoice(var PurchHeader: Record "Purchase Header"; var vendLedgerEntry: Record "vendor Ledger Entry"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean)
    local procedure OnBeforePostGLAndVendor(var PurchHeader: Record "Purchase Header"; var TempInvoicePostBuffer: Record "Invoice Post. Buffer" temporary; PreviewMode: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean)

    var
        d: Codeunit "Purch.-Post";
        TotalAmount: Decimal;
    begin


    end;

    procedure PostWHT(var PurchHeader: Record "Purchase Header"; TotalInvAmount: Decimal; TempPurchLineGlobal: Record "Purchase Line"; PurchInvHeader: Record 122)
    var
        GenJnlLine: Record "Gen. Journal Line";
        GLReg: Record "G/L Register";
        WHTPostingSetup: Record "WHT Posting Setup";
        WHTEntry: Record "WHT Entry";
        PurchCrMemoHeader: record "Purch. Cr. Memo Hdr.";
        purchline: Record "Purchase Line";
        vatat: Decimal;
    begin
        // Message('%1..%2', TempPurchLineGlobal."WHT Business Posting Group", TempPurchLineGlobal."WHT Product Posting Group");
        with PurchHeader do begin
            WHTPostingSetup.Get(TempPurchLineGlobal."WHT Business Posting Group", TempPurchLineGlobal."WHT Product Posting Group");
            clear(vatat);
            purchline.Reset();
            purchline.SetRange("Document No.", PurchHeader."No.");
            if purchline.FindSet() then
                repeat
                    vatat += purchline."Amount Including VAT" - purchline."VAT Base Amount";
                until purchline.Next() = 0;
            // Message('%1', vatat);
            // if (vatat <> 0) and (PurchInvHeader."No." <> '') then begin
            //     InsertGenJournalWHT(PurchHeader, PurchInvHeader, GenJnlLine, WHTPostingSetup.GetPrepaidWHTAccount, -vatat * 1 / 3);
            //     GenJnlPostLine.IncreaseWHTEntryNo;
            //     GenJnlPostLine1.RunWithCheck(GenJnlLine);
            // end;

            if "Document Type" in ["Document Type"::Order, "Document Type"::Invoice] then begin
                // Message('%1..%2', TotalInvAmount, WHTPostingSetup."WHT Minimum Invoice Amount");
                if TotalInvAmount >= WHTPostingSetup."WHT Minimum Invoice Amount" then
                    WHTManagement.InsertVendInvoiceWHT(PurchInvHeader);

                //vatwht
                WHTEntry.Reset();
                WHTEntry.SetRange("Document Type", WHTEntry."Document Type"::Invoice);
                WHTEntry.SetRange("Document No.", PurchInvHeader."No.");
                if WHTEntry.Find('-') then
                    repeat
                        WHTPostingSetup.Get(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                        if (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::Payment) and
                           (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::" ")
                        then
                            if WHTEntry.Amount <> 0 then begin
                                // Message('%1', WHTEntry.Amount);
                                // PurchHeader."WHT Amount" := PurchHeader."WHT Avendormount" + WHTEntry.Amount;
                                InsertGenJournalWHT(PurchHeader, PurchInvHeader, GenJnlLine, WHTPostingSetup.GetPrepaidWHTAccount, -WHTEntry.Amount);
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
                WHTManagement.InsertvendCreditWHT(purchCrMemoHeader, "Applies-to ID");
                WHTEntry.Reset();
                WHTEntry.SetRange("Document Type", WHTEntry."Document Type"::"Credit Memo");
                WHTEntry.SetRange("Document No.", PurchCrMemoHeader."No.");
                if WHTEntry.Find('-') then
                    repeat
                        // message('%1', WHTEntry);
                        WHTPostingSetup.Get(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                        if (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::Payment) and
                           (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::" ")
                        then
                            if WHTEntry.Amount <> 0 then begin

                                //PurchHeader."WHT Amount" := PurchHeader."WHT Amount" + WHTEntry.Amount;
                                InsertGenJournalWHT(PurchHeader, PurchInvHeader, GenJnlLine, WHTPostingSetup.GetPrepaidWHTAccount, -WHTEntry.Amount);
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

        // if (PurchHeader."WHT Amount" <> 0) then
        //   WHTManagement.PrintWHTSlips(GLReg, false);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostBalancingEntry', '', false, false)]
    procedure OnBeforePostBalancingEntry(VAR GenJnlLine: Record "Gen. Journal Line";
    PurchHeader: Record "Purchase Header"; VAR TotalPurchLine: Record "Purchase Line";
    VAR TotalPurchLineLCY: Record "Purchase Line")
    var

        Text28000: label 'You are not allowed to use payment method code when Manual Sales WHT Calc. is checked in General Ledger Setup.';
        GLSetup: Record "General Ledger Setup";
        TotalPurchLine2: Record "Purchase Line";
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
        TempPurchLineGlobal: Record "Purchase Line";
    begin

        //>>PRU_RPG WHT_0.1
        IF GLSetup."Manual Sales WHT Calc." THEN
            ERROR(Text28000);

        GenJnlLine."WHT Business Posting Group" := TempPurchLineGlobal."WHT Business Posting Group";
        GenJnlLine."WHT Product Posting Group" := TempPurchLineGlobal."WHT Product Posting Group";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchLines', '', true, true)]
    local procedure "Purch.-Post_OnAfterPostPurchLines"
    (
        var PurchHeader: Record "Purchase Header";
        //var PurchReceiptHeader: Record "Purch. Rcpt. Header";
        var PurchInvHeader: Record "Purch. Inv. Header";
        // var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        //var ReturnReceiptHeader: Record "Return Receipt Header";
        WhseShip: Boolean;
        WhseReceive: Boolean;
        var PurchLinesProcessed: Boolean;
        CommitIsSuppressed: Boolean;
        EverythingInvoiced: Boolean;
        var TempPurchLineGlobal: Record "Purchase Line"
    )
    begin
        PurchHeader.CalcFields(Amount);
        // Message('%1', PurchHeader.Amount);
        // Message('%1..%2..%3', TempPurchLineGlobal."No.", TempPurchLineGlobal."WHT Business Posting Group", TempPurchLineGlobal."WHT Product Posting Group");
        GLSetup.Get();
        if GLSetup."Enable WHT" then //and (not GLSetup."Enable GST (Australia)")
            PostWHT(PurchHeader, PurchHeader.Amount, TempPurchLineGlobal, PurchInvHeader);
    end;


    ///
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostBalancingEntryOnAfterInitNewLine', '', false, false)]
    local Procedure OnPostBalancingEntryOnAfterInitNewLine(purchHeader: Record "Purchase Header"; var GenJnlLine: Record "Gen. Journal Line")
    begin
        GenJnlLine."WHT Business Posting Group" := TempPurchLineGlobal."WHT Business Posting Group";
        GenJnlLine."WHT Product Posting Group" := TempPurchLineGlobal."WHT Product Posting Group";
    end;
    ////vat wht
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnDivideAmountOnBeforeTempVATAmountLineRemainderModify', '', false, false)]
    local procedure OnDivideAmountOnBeforeTempVATAmountLineRemainderModify(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var TempVATAmountLine: Record "VAT Amount Line" temporary; var TempVATAmountLineRemainder: Record "VAT Amount Line" temporary; Currency: Record Currency);
    begin

    end;





    /*
        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnInsertPostedHeadersOnBeforeInsertInvoiceHeader', '', false, false)]
        local procedure OnInsertPostedHeadersOnBeforeInsertInvoiceHeader(purchHeader: Record "purchase Header"; var IsHandled: Boolean; purchInvHeader: Record 122; var GenJnlLineDocType: Enum "Gen. Journal Document Type"; var GenJnlLineDocNo: Code[20]; var GenJnlLineExtDocNo: Code[35])
        var
            GenJnlLine: Record "Gen. Journal Line";
           purchCrMemoHeader: Record "purch. Cr.Memo Header";
        begin
            if purchHeader.Invoice then begin
                if purchHeader."Document Type" in [purchHeader."Document Type"::Order, purchHeader."Document Type"::Invoice] then begin
                    GenJnlLineDocType := GenJnlLine."Document Type"::Invoice;
                    GenJnlLineDocNo := purchInvHeader."No.";
                    GenJnlLineExtDocNo := purchInvHeader."External Document No.";
                end else begin // Credit Memo
                    GenJnlLineDocType := GenJnlLine."Document Type"::"Credit Memo";
                    GenJnlLineDocNo := purchCrMemoHeader."No.";
                    GenJnlLineExtDocNo := purchCrMemoHeader."External Document No.";
                end;
            end;
        end;
    */



    procedure InsertGenJournalWHT(var PurchHeader: Record "Purchase Header"; PurchInvHeader: record 122; var GenJnlLine: Record "Gen. Journal Line"; AccountNo: Code[20]; AmountWHT: Decimal)
    begin
        with GenJnlLine do begin
            Init();
            "Posting Date" := PurchHeader."Posting Date";
            "Document Date" := PurchHeader."Document Date";
            Description := PurchHeader."Posting Description";
            "Shortcut Dimension 1 Code" := PurchHeader."Shortcut Dimension 1 Code";
            "Shortcut Dimension 2 Code" := PurchHeader."Shortcut Dimension 2 Code";
            "Dimension Set ID" := PurchHeader."Dimension Set ID";
            "Reason Code" := PurchHeader."Reason Code";
            "Account Type" := "Account Type"::"G/L Account";
            "Account No." := AccountNo;
            "Document Type" := "Document Type"::Invoice;
            "Document No." := PurchInvHeader."No.";
            "External Document No." := GenJnlLineExtDocNo;
            "Currency Code" := PurchHeader."Currency Code";
            Amount := AmountWHT;
            "Source Currency Code" := PurchHeader."Currency Code";
            "Source Currency Amount" := AmountWHT;
            if PurchHeader."Currency Code" <> '' then
                "Amount (LCY)" :=
                  Round(
                    CurrExchRate.ExchangeAmtFCYToLCY(
                      PurchHeader."Posting Date", PurchHeader."Currency Code", AmountWHT, PurchHeader."Currency Factor"));
            if PurchHeader."Currency Code" = '' then
                "Currency Factor" := 1
            else
                "Currency Factor" := PurchHeader."Currency Factor";
            //// "Sales/Purch. (LCY)" := -TotalPurchLineLCY.Amount;
            Correction := PurchHeader.Correction;
            // "Inv. Discount (LCY)" := -TotalPurchLineLCY."Inv. Discount Amount";
            "Sell-to/Buy-from No." := PurchHeader."Sell-to Customer No.";
            "Bill-to/Pay-to No." := PurchHeader."Buy-from Vendor No.";
            "System-Created Entry" := true;
            "On Hold" := PurchHeader."On Hold";
            "Allow Application" := PurchHeader."Bal. Account No." = '';
            "Due Date" := PurchHeader."Due Date";
            "Payment Terms Code" := PurchHeader."Payment Terms Code";
            "Source Type" := "Source Type"::Vendor;
            "Source No." := PurchHeader."Buy-from Vendor No.";
            // "Source Code" := SrcCode;
            "Posting No. Series" := PurchHeader."Posting No. Series";
            //"IC Partner Code" := PurchHeader."Sell-to IC Partner Code";
            //  Adjustment := PurchHeader.Adjustment;
            //  "BAS Adjustment" := PurchHeader."BAS Adjustment";
            //  "Adjustment Applies-to" := PurchHeader."Adjustment Applies-to";
            // Message('%1', "Source No.");
        end;
    end;


    procedure CheckWHTApplication(PurchHeader: Record "Purchase Header")
    begin
        with PurchHeader do begin
            if IsCreditDocType() then begin
                if ("Applies-to Doc. Type" = "Applies-to Doc. Type"::Invoice) and ("Applies-to Doc. No." <> '') then
                    WHTManagement.CheckApplicationPurchWHT(PurchHeader);
                if (("Applies-to Doc. Type" = "Applies-to Doc. Type"::Refund) and ("Applies-to Doc. No." <> '')) or
                   ("Applies-to ID" <> '')
                then
                    WHTManagement.CheckApplicationPurchWHT(PurchHeader);
            end;
            //  Message('chechwhtapplication...');
            if "Document Type" in ["Document Type"::Invoice] then begin
                if ("Applies-to Doc. Type" = "Applies-to Doc. Type"::"Credit Memo") and ("Applies-to Doc. No." <> '') then
                    WHTManagement.CheckApplicationPurchWHT(PurchHeader);

                if (("Applies-to Doc. Type" = "Applies-to Doc. Type"::Payment) and ("Applies-to Doc. No." <> '')) or
                   ("Applies-to ID" <> '')
                then
                    WHTManagement.CheckApplicationPurchWHT(PurchHeader);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostVendorEntry', '', true, true)]
    local procedure "Purch.-Post_OnBeforePostVendorEntry"
      (
           var GenJnlLine: Record "Gen. Journal Line";
     var PurchHeader: Record "Purchase Header";
     var TotalPurchLine: Record "Purchase Line";
     var TotalPurchLineLCY: Record "Purchase Line";
     //CommitIsSuppressed: Boolean;
     PreviewMode: Boolean;
     var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"
      )
    var
        WHTEntry: Record "WHT Entry";
        WHTPostingSetup: Record "WHT Posting Setup";
        vatamt: Decimal;

    begin
        vatamt := TotalPurchLineLCY."Amount Including VAT" - TotalPurchLineLCY."VAT Base Amount";
        // Message('%1..%2', GenJnlLine.Amount, vatamt / 3);
        // if vatamt <> 0 then begin
        //     GenJnlLine.Amount := GenJnlLine.Amount + (vatamt / 3) / 2;
        //     GenJnlLine."Amount (LCY)" := GenJnlLine.Amount + (vatamt / 3) / 2;
        // end;
        WHTEntry.Reset();
        WHTEntry.SetRange("Document Type", WHTEntry."Document Type"::Invoice);
        WHTEntry.SetRange("Document No.", GenJnlLine."Document No.");
        if WHTEntry.Find('-') then
            repeat
                WHTPostingSetup.Get(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                if (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::Payment) and
                   (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::" ")
                then
                    if WHTEntry.Amount <> 0 then begin
                        GenJnlLine.Amount := GenJnlLine.Amount + WHTEntry.Amount;
                        GenJnlLine."Amount (LCY)" := GenJnlLine."Amount (LCY)" + WHTEntry.Amount;  //glwht
                                                                                                   // Message('%1', GenJnlLine.Amount);
                    END;
            until WHTEntry.Next() = 0;

        GenJnlLine."Vendor Type" := PurchHeader."Vendor Type"; //PruRaj
                                                               ///wht codes
        GenJnlLine."WHT Business Posting Group" := TempPurchLineGlobal."WHT Business Posting Group";
        GenJnlLine."WHT Product Posting Group" := TempPurchLineGlobal."WHT Product Posting Group";
    END;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGlobalGLEntry', '', true, true)]
    local procedure "Gen. Jnl.-Post Line_OnBeforeInsertGlobalGLEntry"
    (
        var GlobalGLEntry: Record "G/L Entry";
        GenJournalLine: Record "Gen. Journal Line";
        GLRegister: Record "G/L Register"
    )
    begin
        // Message('%1 --', GlobalGLEntry.Amount);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterSettingIsTransactionConsistent', '', true, true)]
    local procedure "Gen. Jnl.-Post Line_OnAfterSettingIsTransactionConsistent"
    (
        GenJournalLine: Record "Gen. Journal Line";
        var IsTransactionConsistent: Boolean
    )
    var
        WHTEntry: Record "WHT Entry";
        WHTPostingSetup: Record "WHT Posting Setup";
    begin
        WHTEntry.Reset();
        WHTEntry.SetRange("Document Type", WHTEntry."Document Type"::Invoice);
        WHTEntry.SetRange("Document No.", GenJournalLine."Document No.");
        if WHTEntry.Find('-') then
            repeat
                WHTPostingSetup.Get(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                if (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::Payment) and
                   (WHTPostingSetup."Realized WHT Type" <> WHTPostingSetup."Realized WHT Type"::" ")
                then
                    if WHTEntry.Amount <> 0 then begin
                        IsTransactionConsistent := true;
                    END;
            until WHTEntry.Next() = 0;

    end;


}