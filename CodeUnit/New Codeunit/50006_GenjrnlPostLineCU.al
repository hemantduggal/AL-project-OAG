codeunit 50006 GenJnlPostLine
{
    /*
    [EventSubscriber(ObjectType::Codeunit, 12, 'InitCustLedgEntry', '', false, false)]
    local procedure InitCustLedgEntry(GenJnlLine: Record 81; var CustLedgEntry: Record 21)
    begin

        //>>ALOB_0.1 PRU_RPG
        CustLedgEntry."Global Dimension 1 Code" := GenJnlLine."Shortcut Dimension 1 Code";
        CustLedgEntry."Global Dimension 2 Code" := GenJnlLine."Shortcut Dimension 2 Code";
        CustLedgEntry."Shortcut Dimension 3 Code" := GenJnlLine."Shortcut Dimension 3 Code";
        CustLedgEntry."Shortcut Dimension 4 Code" := GenJnlLine."Shortcut Dimension 4 Code";  //ADF_0.1 PRU_RPG
        //<<ALOB_0.1 PRU_RPG
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'InitVendLedgEntry', '', false, false)]

    local procedure InitVendLedgEntry(GenJnlLine: Record 81; var VendLedgEntry: Record 25)
    begin

        //>>ALOB_0.1 PRU_RPG
        VendLedgEntry."Global Dimension 1 Code" := GenJnlLine."Shortcut Dimension 1 Code";
        VendLedgEntry."Global Dimension 2 Code" := GenJnlLine."Shortcut Dimension 2 Code";
        VendLedgEntry."Shortcut Dimension 3 Code" := GenJnlLine."Shortcut Dimension 3 Code";
        VendLedgEntry."Shortcut Dimension 4 Code" := GenJnlLine."Shortcut Dimension 4 Code";  //ADF_0.1 PRU_RPG
        //<<ALOB_0.1 PRU_RPG
    end;
*/
    /*   [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforePostGLAcc', '', false, false)]
       procedure OnBeforePostGLAcc(GenJournalLine: Record "Gen. Journal Line"; VAR GLEntry: Record "G/L Entry")
       var

           GLAcc: Record "G/L Account";
           GLEntry1: Record "G/L Entry";
           VATPostingSetup: Record "VAT Posting Setup";
           IsHandled: Boolean;
           WHTPostingSetup: Record "WHT Posting Setup";
           WHTAmountLCY: Decimal;
           WHTAmount: Decimal;
       begin
           // G/L entry
           CalcGLAccWHT(GenJournalLine, WHTPostingSetup, WHTAmountLCY, WHTAmount);  //PRU_RPG WHT_0.1
                                                                                    // G/L entry
       end;

       [EventSubscriber(ObjectType::Codeunit, 12, 'OnPostGLAccOnBeforeInsertGLEntry', '', false, false)]
       procedure OnPostGLAccOnBeforeInsertGLEntry(VAR GenJournalLine: Record "Gen. Journal Line"; VAR GLEntry: Record "G/L Entry"; VAR IsHandled: Boolean)
       var
           WHTPostingSetup: Record "WHT Posting Setup";
           WHTAmountLCY: Decimal;
           WHTAmount: Decimal;
       begin
           PostGLAccWHT(GenJournalLine, WHTPostingSetup, WHTAmountLCY);  //PRU_RPG WHT_0.1
       end;

       Procedure CalcGLAccWHT(GenJnlLine: Record "Gen. Journal Line"; VAR WHTPostingSetup: Record "WHT Posting Setup"; VAR WHTAmountLCY: Decimal; VAR WHTAmount: Decimal)
       var

       begin

           WITH GenJnlLine DO BEGIN
               WHTAmountLCY := 0;
               IF GLSetup."Enable WHT" THEN
                   IF NOT "Skip WHT" THEN
                       IF ("Applies-to ID" = '') AND ("Applies-to Doc. No." = '') THEN BEGIN
                           IF ("Document Type" = "Document Type"::Payment) OR
                              ("Document Type" = "Document Type"::Refund)
                           THEN
                               IF WHTPostingSetup.GET(
                                    "WHT Business Posting Group",
                                    "WHT Product Posting Group")
                               THEN
                                   IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN
                                       IF IsCustAcc(GenJnlLine) THEN BEGIN
                                           IF "WHT Absorb Base" <> 0 THEN
                                               WHTAmountLCY :=
                                                 -ABS(ROUND("WHT Absorb Base" * WHTPostingSetup."WHT %" / 100))
                                           ELSE
                                               WHTAmountLCY :=
                                                 -ABS(ROUND(Amount * WHTPostingSetup."WHT %" / 100));
                                           IF "Document Type" = "Document Type"::Refund THEN
                                               WHTAmountLCY := ABS(WHTAmountLCY);
                                       END ELSE
                                           IF IsVendAcc(GenJnlLine) THEN BEGIN
                                               IF "WHT Absorb Base" <> 0 THEN
                                                   WHTAmountLCY :=
                                                     ABS(ROUND("WHT Absorb Base" * WHTPostingSetup."WHT %" / 100))
                                               ELSE
                                                   WHTAmountLCY :=
                                                     ABS(ROUND(Amount * WHTPostingSetup."WHT %" / 100));

                                               IF "Document Type" = "Document Type"::Refund THEN
                                                   WHTAmountLCY := -ABS(WHTAmountLCY);
                                           END;
                       END ELSE
                           IF ("Applies-to ID" <> '') OR ("Applies-to Doc. No." <> '') THEN BEGIN
                               GenJnlLine1.RESET;
                               GenJnlLine1.COPY(GenJnlLine);
                               IF "Applies-to Doc. No." <> '' THEN
                                   GenJnlLine1.SETRANGE("Applies-to Doc. No.", "Applies-to Doc. No.")
                               ELSE
                                   GenJnlLine1.SETRANGE("Applies-to ID", "Applies-to ID");

                               GenJnlLine1.SETRANGE("Account Type", "Account Type"::Vendor);
                               IF ("Account Type" = "Account Type"::Vendor) OR
                                  ("Bal. Account Type" = "Bal. Account Type"::Vendor) OR
                                  GenJnlLine1.FINDFIRST
                               THEN BEGIN
                                   CurrFactor := GenJnlLine1."Currency Factor";
                                   IF GenJnlLine1."Interest Amount" <> 0 THEN
                                       GenJnlLine1.VALIDATE(Amount, GenJnlLine1.Amount - GenJnlLine1."Interest Amount");

                                   IF ("Document Type" = "Document Type"::Payment) OR
                                      ("Document Type" = "Document Type"::Refund)
                                   THEN
                                       IF WHTPostingSetup.GET(
                                            "WHT Business Posting Group",
                                            "WHT Product Posting Group")
                                       THEN BEGIN
                                           IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                               IF GenJnlLine1.FINDFIRST THEN
                                                   WHTManagement.CheckApplicationGenPurchWHT(GenJnlLine1);
                                               WHTAmountLCY :=
                                                 CurrExchRate.ExchangeAmtFCYToLCY(
                                                   "Document Date",
                                                   "Currency Code",
                                                   ABS(
                                                     WHTManagement.CalcVendExtraWHTForEarliest(GenJnlLine1)), CurrFactor);
                                           END;

                                           IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment) AND
                                              (NOT GLSetup."Manual Sales WHT Calc.")
                                           THEN
                                               WHTAmountLCY :=
                                                 CurrExchRate.ExchangeAmtFCYToLCY(
                                                   "Document Date",
                                                   "Currency Code",
                                                   ABS(
                                                     WHTManagement.WHTAmountJournal(GenJnlLine1, TRUE)), CurrFactor);
                                       END;
                                   IF "Document Type" = "Document Type"::Refund THEN
                                       WHTAmountLCY := -ABS(WHTAmountLCY);
                               END;

                               //          IF IsCustAcc(GenJnlLine) AND NOT GLSetup."Enable GST (Australia)" THEN BEGIN
                               IF IsCustAcc(GenJnlLine) THEN BEGIN
                                   CurrFactor :=
                                     CurrExchRate.ExchangeRate(
                                       GenJnlLine1."Document Date", "Currency Code");
                                   IF "Bal. Account Type" = "Bal. Account Type"::Customer THEN
                                       GenJnlLine1.VALIDATE(Amount, -GenJnlLine1.Amount);

                                   IF IsPaymentOrRefund(GenJnlLine) THEN
                                       IF WHTPostingSetup.GET("WHT Business Posting Group", "WHT Product Posting Group") THEN BEGIN
                                           IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest) THEN BEGIN
                                               IF GenJnlLine1.FINDFIRST THEN
                                                   WHTManagement.CheckApplicationGenSalesWHT(GenJnlLine1);
                                               WHTAmountLCY :=
                                                 -CurrExchRate.ExchangeAmtFCYToLCY(
                                                   "Document Date",
                                                   "Currency Code",
                                                   ABS(
                                                     WHTManagement.CalcCustExtraWHTForEarliest(GenJnlLine)), CurrFactor);
                                           END;

                                           IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment) AND
                                              (NOT GLSetup."Manual Sales WHT Calc.")
                                           THEN
                                               WHTAmountLCY :=
                                                 -CurrExchRate.ExchangeAmtFCYToLCY(
                                                   GenJnlLine1."Document Date",
                                                   GenJnlLine1."Currency Code",
                                                   ABS(
                                                     WHTManagement.ApplyCustCalcWHT(GenJnlLine1)), CurrFactor);
                                       END;

                                   IF "Document Type" = "Document Type"::Refund THEN
                                       WHTAmountLCY := -ABS(WHTAmountLCY);
                               END;
                               WHTAmountLCY := ROUND(WHTAmountLCY);
                           END;

               IF WHTPostingSetup.GET("WHT Business Posting Group",
                    "WHT Product Posting Group")
               THEN
                   IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                       IF ABS(Amount) < WHTPostingSetup."WHT Minimum Invoice Amount" THEN
                           WHTAmountLCY := 0;
                   END;
           END;
       end;

       procedure PostGLAccWHT(GenJnlLine: Record "Gen. Journal Line"; WHTPostingSetup: Record "WHT Posting Setup"; WHTAmountLCY: Decimal)
       begin
           IF WHTAmountLCY = 0 THEN
               EXIT;

           WITH GenJnlLine DO BEGIN
               IF "Document Type" = "Document Type"::Invoice THEN
                   EXIT;

               CASE TRUE OF
                   IsVendAcc(GenJnlLine):
                       IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN
                           GenJNLpstLine.CreateGLEntry(
                              GenJnlLine, WHTPostingSetup."Payable WHT Account Code", -WHTAmountLCY, -WHTAmountLCY, TRUE);
                   IsCustAcc(GenJnlLine):
                       IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN
                           GenJNLpstLine.CreateGLEntry(
                              GenJnlLine, WHTPostingSetup."Prepaid WHT Account Code", -WHTAmountLCY, -WHTAmountLCY, TRUE);
               END;
           END;
       end;

       procedure CalcCustWHT(GenJnlLine: Record "Gen. Journal Line"; VAR WHTPostingSetup: Record "WHT Posting Setup"; VAR WHTAmountLCY: Decimal; VAR WHTAmount: Decimal)
       begin
           WITH GenJnlLine DO BEGIN
               WHTAmountLCY := 0;
               SourceCodeSetup.GET;
               IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN BEGIN
                   GenJnlLine1.RESET;
                   GenJnlLine1.COPY(GenJnlLine);
                   IF GLSetup."Enable WHT" THEN
                       IF NOT GenJnlLine1."Skip WHT" THEN
                           IF (GenJnlLine1."Applies-to Doc. No." = '') AND
                              (GenJnlLine1."Applies-to ID" = '')
                           THEN BEGIN
                               IF (((GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Invoice) OR
                                    (GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::"Credit Memo")) AND
                                   ((GenJnlLine1."Account Type" = GenJnlLine1."Account Type"::"G/L Account") OR
                                    (GenJnlLine1."Bal. Account Type" = GenJnlLine1."Bal. Account Type"::"G/L Account")))
                               THEN
                                   IF WHTPostingSetup.GET(GenJnlLine1."WHT Business Posting Group", GenJnlLine1."WHT Product Posting Group") THEN
                                       IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                                          (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                                       THEN BEGIN
                                           IF GenJnlLine1."WHT Absorb Base" <> 0 THEN
                                               WHTAmountLCY := -ROUND(GenJnlLine1."WHT Absorb Base" * WHTPostingSetup."WHT %" / 100)
                                           ELSE
                                               WHTAmountLCY := ROUND(GenJnlLine1.Amount * WHTPostingSetup."WHT %" / 100);
                                           WHTAmount := WHTAmountLCY;
                                       END;
                           END ELSE
                               IF (((GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Invoice) OR
                                    (GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::"Credit Memo")) AND
                                   ((GenJnlLine1."Account Type" = GenJnlLine1."Account Type"::"G/L Account") OR
                                    (GenJnlLine1."Bal. Account Type" = GenJnlLine1."Bal. Account Type"::"G/L Account")))
                               THEN
                                   IF WHTPostingSetup.GET(GenJnlLine1."WHT Business Posting Group", GenJnlLine1."WHT Product Posting Group") THEN BEGIN
                                       IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest) THEN BEGIN
                                           GenJnlLine1.RESET;
                                           GenJnlLine1.COPY(GenJnlLine);
                                           IF GenJnlLine1.FINDFIRST THEN
                                               WHTManagement.CheckApplicationGenSalesWHT(GenJnlLine1);
                                           WHTAmountLCY := ROUND(WHTManagement.CalcCustExtraWHTForEarliest(GenJnlLine1));
                                           WHTAmount := WHTAmountLCY;
                                       END;

                                       IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) THEN BEGIN
                                           GenJnlLine1.RESET;
                                           GenJnlLine1.COPY(GenJnlLine);
                                           IF GenJnlLine1.FINDFIRST THEN
                                               WHTManagement.CheckApplicationGenSalesWHT(GenJnlLine1);
                                           IF GenJnlLine1."WHT Absorb Base" <> 0 THEN
                                               WHTAmountLCY := -ROUND(GenJnlLine1."WHT Absorb Base" * WHTPostingSetup."WHT %" / 100)
                                           ELSE
                                               WHTAmountLCY := ROUND(GenJnlLine1.Amount * WHTPostingSetup."WHT %" / 100);
                                           WHTAmount := WHTAmountLCY;
                                       END;
                                   END;

                   IF GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Invoice THEN BEGIN
                       IF "Currency Code" <> '' THEN
                           WHTAmountLCY :=
                             ABS(ROUND(
                                 CurrExchRate.ExchangeAmtFCYToLCY(
                                   "Posting Date", "Currency Code", WHTAmountLCY,
                                   CurrExchRate.ExchangeRate("Posting Date", "Currency Code"))))
                       ELSE
                           WHTAmountLCY := ABS(WHTAmountLCY);
                       WHTAmount := ABS(WHTAmount);
                   END ELSE BEGIN
                       IF "Currency Code" <> '' THEN
                           WHTAmountLCY :=
                             -ABS(ROUND(
                                 CurrExchRate.ExchangeAmtFCYToLCY(
                                   "Posting Date", "Currency Code", WHTAmountLCY,
                                   CurrExchRate.ExchangeRate("Posting Date", "Currency Code"))))
                       ELSE
                           WHTAmountLCY := -ABS(WHTAmountLCY);
                       WHTAmount := -ABS(WHTAmount);
                   END;
               END;
           END;

       end;

       procedure PostCustWHT(GenJnlLine: Record "Gen. Journal Line"; CustLedgEntry: Record "Cust. Ledger Entry"; WHTPostingSetup: Record "WHT Posting Setup"; WHTAmountLCY: Decimal)

       begin

           WITH GenJnlLine DO BEGIN
               IF WHTAmountLCY <> 0 THEN
                   IF ((GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Invoice) OR
                       (GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::"Credit Memo"))
                   THEN
                       IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                          (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                       THEN BEGIN
                           WHTPostingSetup.TESTFIELD("Prepaid WHT Account Code");
                           GenJNLpstLine.CreateGLEntry(
                             GenJnlLine, WHTPostingSetup."Prepaid WHT Account Code", WHTAmountLCY, WHTAmountLCY, TRUE);
                       END;

               SourceCodeSetup.GET;
               IF "Source Code" <> SourceCodeSetup."Financially Voided Check" THEN BEGIN
                   GenJnlLine1.RESET;
                   GenJnlLine1.COPY(GenJnlLine);
                   //IF GLSetup."Enable WHT" AND (NOT GLSetup."Enable GST (Australia)") THEN
                   IF GLSetup."Enable WHT" THEN
                       IF IsAboveWHTMinInvoiceAmount(GenJnlLine) THEN BEGIN
                           IF NOT "Skip WHT" THEN BEGIN
                               IF ("Applies-to Doc. No." <> '') OR ("Applies-to ID" <> '') THEN BEGIN
                                   KeepWHTEntryNo := NextWHTEntryNo;
                                   CASE "Document Type" OF
                                       "Document Type"::Payment:
                                           IF GLSetup."Manual Sales WHT Calc." THEN BEGIN
                                               IF "WHT Payment" THEN
                                                   NextWHTEntryNo := WHTManagement.ApplyManualCustInvoiceWHT(CustLedgEntry, GenJnlLine1);
                                           END ELSE
                                               IF WHTPostingSetup.GET(
                                                    "WHT Business Posting Group",
                                                    "WHT Product Posting Group")
                                               THEN BEGIN
                                                   IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
                                                       NextWHTEntryNo := WHTManagement.ApplyCustInvoiceWHT(CustLedgEntry, GenJnlLine1);
                                                       IF NextWHTEntryNo <> -1 THEN
                                                           HadWHTEntryNo := TRUE
                                                       ELSE
                                                           NextWHTEntryNo := KeepWHTEntryNo;
                                                   END;

                                                   IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                                       NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine);
                                                       IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                           WHTEntry."Transaction No." := NextTransactionNo;
                                                           WHTEntry.MODIFY;
                                                       END;
                                                   END;
                                               END;
                                       "Document Type"::Invoice:
                                           BEGIN
                                               IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN
                                                   IF WHTPostingSetup.GET("WHT Business Posting Group", "WHT Product Posting Group") THEN
                                                       IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                                                          (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                                                       THEN BEGIN
                                                           GenJnlLine2.RESET;
                                                           GenJnlLine2.COPY(GenJnlLine);
                                                           GenJnlLine2.Amount := ABS(GenJnlLine2.Amount);
                                                           GenJnlLine2."WHT Absorb Base" := ABS(GenJnlLine2."WHT Absorb Base");
                                                           NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine2);
                                                           IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                               WHTEntry."Transaction No." := NextTransactionNo;
                                                               WHTEntry.MODIFY;
                                                           END;
                                                       END;
                                               IF SourceCodeSetup.Sales = "Source Code" THEN
                                                   UpdateWHTEntryTransaction("Document No.");
                                           END;
                                       "Document Type"::"Credit Memo":
                                           BEGIN
                                               IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN
                                                   IF WHTPostingSetup.GET("WHT Business Posting Group", "WHT Product Posting Group") THEN
                                                       IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                                                          (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                                                       THEN BEGIN
                                                           GenJnlLine2.RESET;
                                                           GenJnlLine2.COPY(GenJnlLine);
                                                           GenJnlLine2.Amount := ABS(GenJnlLine2.Amount);
                                                           GenJnlLine2."WHT Absorb Base" := ABS(GenJnlLine2."WHT Absorb Base");
                                                           NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine2);
                                                           IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                               WHTEntry."Transaction No." := NextTransactionNo;
                                                               WHTEntry.MODIFY;
                                                           END;
                                                       END;

                                               IF SourceCodeSetup.Sales = "Source Code" THEN
                                                   UpdateWHTEntryTransaction("Document No.");
                                           END;
                                       "Document Type"::Refund:
                                           IF GLSetup."Manual Sales WHT Calc." THEN BEGIN
                                               IF "WHT Payment" THEN
                                                   NextWHTEntryNo := WHTManagement.ApplyManualCustInvoiceWHT(CustLedgEntry, GenJnlLine1);
                                           END ELSE
                                               IF WHTPostingSetup.GET("WHT Business Posting Group", "WHT Product Posting Group") THEN BEGIN
                                                   IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
                                                       NextWHTEntryNo := WHTManagement.ApplyCustInvoiceWHT(CustLedgEntry, GenJnlLine1);
                                                       IF NextWHTEntryNo <> -1 THEN
                                                           HadWHTEntryNo := TRUE
                                                       ELSE
                                                           NextWHTEntryNo := KeepWHTEntryNo;
                                                   END;

                                                   IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                                       NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine);
                                                       IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                           WHTEntry."Transaction No." := NextTransactionNo;
                                                           WHTEntry.MODIFY;
                                                       END;
                                                   END;
                                               END;
                                   END;
                                   TempGenJnlTemp.SETRANGE(Type, TempGenJnlTemp.Type::Sales);
                                   IF TempGenJnlTemp.FINDFIRST THEN
                                       IF "Journal Template Name" = TempGenJnlTemp.Name THEN BEGIN
                                           WHTEntry.RESET;
                                           WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Payment);
                                           WHTEntry.SETRANGE("Document No.", "Document No.");
                                           WHTEntry.SETRANGE("Bill-to/Pay-to No.", "Account No.");
                                           WHTEntry.SETFILTER("Remaining Unrealized Amount", '<>0');
                                           IF WHTEntry.FIND('-') THEN
                                               REPEAT
                                                   WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                                   WHTPostingSetup.TESTFIELD("Prepaid WHT Account Code");
                                                   GenJNLpstLine.CreateGLEntry(
                                                     GenJnlLine, WHTPostingSetup."Prepaid WHT Account Code", -WHTEntry."Amount (LCY)", "Source Currency Amount", TRUE);
                                               UNTIL WHTEntry.NEXT = 0;
                                       END;
                               END ELSE
                                   KeepWHTEntryNo := NextWHTEntryNo;
                               CASE "Document Type" OF
                                   "Document Type"::Invoice:
                                       BEGIN
                                           IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN BEGIN
                                               GenJnlLine2.RESET;
                                               GenJnlLine2.COPY(GenJnlLine);
                                               GenJnlLine2.Amount := -ABS(GenJnlLine2.Amount);
                                               GenJnlLine2."WHT Absorb Base" := -ABS(GenJnlLine2."WHT Absorb Base");
                                               NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine2);
                                           END;
                                           UpdateWHTEntryTransaction("Document No.");
                                       END;
                                   "Document Type"::"Credit Memo":
                                       BEGIN
                                           IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN BEGIN
                                               GenJnlLine2.RESET;
                                               GenJnlLine2.COPY(GenJnlLine);
                                               GenJnlLine2.Amount := ABS(GenJnlLine2.Amount);
                                               GenJnlLine2."WHT Absorb Base" := ABS(GenJnlLine2."WHT Absorb Base");
                                               NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine2);
                                           END;
                                           UpdateWHTEntryTransaction("Document No.");
                                       END;
                                   "Document Type"::Payment:
                                       IF WHTPostingSetup.GET("WHT Business Posting Group", "WHT Product Posting Group") THEN
                                           IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                               GenJnlLine2.RESET;
                                               GenJnlLine2.COPY(GenJnlLine);
                                               GenJnlLine2.Amount := -ABS(GenJnlLine2.Amount);
                                               GenJnlLine2."WHT Absorb Base" := -ABS(GenJnlLine2."WHT Absorb Base");
                                               NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine2);
                                               IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                   WHTEntry."Transaction No." := NextTransactionNo;
                                                   WHTEntry.MODIFY;
                                               END;
                                           END ELSE
                                               IF GLSetup."Manual Sales WHT Calc." THEN
                                                   IF "WHT Payment" THEN BEGIN
                                                       GenJnlLine2.RESET;
                                                       GenJnlLine2.COPY(GenJnlLine);
                                                       GenJnlLine2.Amount := -ABS(GenJnlLine2.Amount);
                                                       GenJnlLine2."WHT Absorb Base" := -ABS(GenJnlLine2."WHT Absorb Base");
                                                       NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine2);
                                                       InsertWHTPaymentGL(GenJnlLine2, GenJnlLine, CustLedgEntry."Entry No.");
                                                       IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                           WHTEntry."Transaction No." := NextTransactionNo;
                                                           WHTEntry.MODIFY;
                                                       END;
                                                   END;
                                   "Document Type"::Refund:
                                       IF WHTPostingSetup.GET("WHT Business Posting Group", "WHT Product Posting Group") THEN
                                           IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                               GenJnlLine2.RESET;
                                               GenJnlLine2.COPY(GenJnlLine);
                                               GenJnlLine2.Amount := -ABS(GenJnlLine2.Amount);
                                               GenJnlLine2."WHT Absorb Base" := -ABS(GenJnlLine2."WHT Absorb Base");
                                               NextWHTEntryNo := WHTManagement.InsertCustJournalWHT(GenJnlLine2);
                                               IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                   WHTEntry."Transaction No." := NextTransactionNo;
                                                   WHTEntry.MODIFY;
                                               END;
                                           END;
                               END;
                           END
                       END;
                   IF NextWHTEntryNo = 0 THEN
                       NextWHTEntryNo := KeepWHTEntryNo;

                   PostCustWHTTaxInv(GenJnlLine, CustLedgEntry);

                   IF "Applies-to ID" <> '' THEN BEGIN
                       CustLedgEntry.RESET;
                       CustLedgEntry.SETCURRENTKEY("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
                       IF "Account Type" = "Account Type"::Customer THEN
                           CustLedgEntry.SETRANGE("Customer No.", "Account No.");
                       CustLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                       CustLedgEntry.SETRANGE("Amount to Apply", 0);
                       IF CustLedgEntry.FINDFIRST THEN
                           CustLedgEntry.MODIFYALL("Applies-to ID", '');
                   END;
               END;
           END;
       end;



       procedure IsAboveWHTMinInvoiceAmount(GenJnlLine: Record "Gen. Journal Line"): Boolean
       begin
           WITH GenJnlLine DO BEGIN
               IF NOT ("Document Type" IN ["Document Type"::Invoice, "Document Type"::"Credit Memo"]) THEN
                   EXIT(TRUE);

               IF WHTPostingSetup.GET("WHT Business Posting Group", "WHT Product Posting Group") THEN
                   EXIT(ABS(Amount) >= WHTPostingSetup."WHT Minimum Invoice Amount");
               EXIT(FALSE);
           END;
       end;

       procedure UpdateWHTEntryTransaction(DocNo: Code[20])
       begin
           WHTEntry.RESET;
           WHTEntry.SETCURRENTKEY("Document No.", "Posting Date");
           WHTEntry.SETRANGE("Document No.", DocNo);
           IF WHTEntry.FINDSET(TRUE, FALSE) THEN
               REPEAT
                   WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                   IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                      (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                   THEN BEGIN
                       WHTEntry."Transaction No." := NextTransactionNo;
                       WHTEntry.MODIFY;
                   END;
               UNTIL WHTEntry.NEXT = 0;
       end;

       procedure InsertWHTPaymentGL(GenJnlLine: Record "Gen. Journal Line"; VAR GenJnlLineWHT: Record "Gen. Journal Line"; VAR EntryNo: Integer)
       var
           GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
       begin
           WITH GenJnlLineWHT DO BEGIN
               WHTPostingSetup.GET("WHT Business Posting Group", "WHT Product Posting Group");
               IF "Bal. Account Type" = "Bal. Account Type"::"Bank Account" THEN BEGIN
                   "Line No." += 10000;
                   BankAcc.GET("Bal. Account No.");
                   BankAccPostingGr.GET(BankAcc."Bank Acc. Posting Group");
               END;
               WHTPostingSetup.TESTFIELD("Prepaid WHT Account Code");
               GenJNLpstLine.CreateGLEntry(
                 GenJnlLineWHT, WHTPostingSetup."Prepaid WHT Account Code", -GenJnlLine.Amount, -GenJnlLine.Amount, TRUE);
               GenJNLpstLine.CreateGLEntry(
                 GenJnlLineWHT, BankAccPostingGr."G/L Account No.", GenJnlLine.Amount, GenJnlLine.Amount, TRUE);

               BankAccLedgEntry.LOCKTABLE;
               IF BankAcc."No." <> "Bal. Account No." THEN
                   BankAcc.GET("Bal. Account No.");
               BankAcc.TESTFIELD(Blocked, FALSE);
               IF "Currency Code" = '' THEN
                   BankAcc.TESTFIELD("Currency Code", '')
               ELSE
                   IF BankAcc."Currency Code" <> '' THEN
                       TESTFIELD("Currency Code", BankAcc."Currency Code");

               BankAcc.TESTFIELD("Bank Acc. Posting Group");
               BankAccPostingGr.GET(BankAcc."Bank Acc. Posting Group");

               BankAccLedgEntry.INIT;
               BankAccLedgEntry."Bank Account No." := "Bal. Account No.";
               BankAccLedgEntry."Posting Date" := "Posting Date";
               BankAccLedgEntry."Document Date" := "Document Date";
               BankAccLedgEntry."Document Type" := "Document Type";
               BankAccLedgEntry."Document No." := "Document No.";
               BankAccLedgEntry."External Document No." := "External Document No.";
               BankAccLedgEntry.Description := Description;
               BankAccLedgEntry."Bank Acc. Posting Group" := BankAcc."Bank Acc. Posting Group";
               BankAccLedgEntry."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
               BankAccLedgEntry."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
               BankAccLedgEntry."Our Contact Code" := "Salespers./Purch. Code";
               BankAccLedgEntry."Source Code" := "Source Code";
               BankAccLedgEntry."Journal Batch Name" := "Journal Batch Name";
               BankAccLedgEntry."Reason Code" := "Reason Code";
               BankAccLedgEntry."Entry No." := NextEntryNo;
               BankAccLedgEntry."Transaction No." := NextTransactionNo;
               BankAccLedgEntry."Currency Code" := BankAcc."Currency Code";

               CalcBankAccWHT2(GenJnlLine, WHTPostingSetup, WHTAmountLCY, WHTAmount);

               IF BankAcc."Currency Code" <> '' THEN
                   BankAccLedgEntry.Amount := Amount
               ELSE
                   BankAccLedgEntry.Amount := "Amount (LCY)" + WHTAmountLCY;
               BankAccLedgEntry."Amount (LCY)" := "Amount (LCY)" + WHTAmountLCY;
               BankAccLedgEntry."User ID" := USERID;
               IF BankAccLedgEntry.Amount <> 0 THEN BEGIN
                   BankAccLedgEntry.Open := TRUE;
                   BankAccLedgEntry."Remaining Amount" := BankAccLedgEntry.Amount;
               END;
               BankAccLedgEntry.Positive := BankAccLedgEntry.Amount > 0;
               BankAccLedgEntry."Bal. Account Type" := "Bal. Account Type";
               BankAccLedgEntry."Bal. Account No." := "Bal. Account No.";
               IF (Amount > 0) AND (NOT Correction) OR
                  ("Amount (LCY)" > 0) AND (NOT Correction) OR
                  (Amount < 0) AND Correction OR
                  ("Amount (LCY)" < 0) AND Correction
               THEN BEGIN
                   BankAccLedgEntry."Debit Amount" := BankAccLedgEntry.Amount;
                   BankAccLedgEntry."Credit Amount" := 0;
                   BankAccLedgEntry."Debit Amount (LCY)" := BankAccLedgEntry."Amount (LCY)";
                   BankAccLedgEntry."Credit Amount (LCY)" := 0;
               END ELSE BEGIN
                   BankAccLedgEntry."Debit Amount" := 0;
                   BankAccLedgEntry."Credit Amount" := -BankAccLedgEntry.Amount;
                   BankAccLedgEntry."Debit Amount (LCY)" := 0;
                   BankAccLedgEntry."Credit Amount (LCY)" := -BankAccLedgEntry."Amount (LCY)";
               END;
               BankAccLedgEntry.INSERT;
           END;
       end;

       procedure CalcBankAccWHT2(GenJnlLine: Record "Gen. Journal Line"; VAR WHTPostingSetup: Record "WHT Posting Setup"; VAR WHTAmountLCY: Decimal; VAR WHTAmount: Decimal)
       begin
           WHTAmountLCY := 0;
           WITH GenJnlLine DO BEGIN
               IF NOT GLSetup."Enable WHT" OR "Skip WHT" THEN
                   EXIT;

               IF ("Applies-to ID" = '') AND ("Applies-to Doc. No." = '') THEN BEGIN
                   IF IsPaymentOrRefund(GenJnlLine) THEN
                       IF WHTPostingSetup.GET("WHT Business Posting Group", "WHT Product Posting Group") THEN
                           IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN
                               IF IsCustAcc(GenJnlLine) THEN BEGIN
                                   IF "WHT Absorb Base" <> 0 THEN
                                       WHTAmountLCY := -ABS(ROUND("WHT Absorb Base" * WHTPostingSetup."WHT %" / 100))
                                   ELSE
                                       WHTAmountLCY := -ABS(ROUND(Amount * WHTPostingSetup."WHT %" / 100));
                                   IF "Document Type" = "Document Type"::Refund THEN
                                       WHTAmountLCY := ABS(WHTAmountLCY);
                               END ELSE
                                   IF IsVendAcc(GenJnlLine) THEN BEGIN
                                       IF "WHT Absorb Base" <> 0 THEN
                                           WHTAmountLCY :=
                                             ABS(ROUND("WHT Absorb Base" * WHTPostingSetup."WHT %" / 100))
                                       ELSE
                                           WHTAmountLCY :=
                                             ABS(ROUND(Amount * WHTPostingSetup."WHT %" / 100));
                                       IF "Document Type" = "Document Type"::Refund THEN
                                           WHTAmountLCY := -ABS(WHTAmountLCY);
                                   END;
                   IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment) AND
                      (NOT GLSetup."Manual Sales WHT Calc.")
                   THEN
                       WHTAmountLCY :=
                         CurrExchRate.ExchangeAmtFCYToLCY(
                           GenJnlLine1."Document Date",
                           GenJnlLine1."Currency Code",
                           ABS(
                             WHTManagement.WHTAmountJournal(GenJnlLine1, TRUE)), CurrFactor);
               END ELSE
                   IF ("Applies-to ID" <> '') OR ("Applies-to Doc. No." <> '') THEN BEGIN
                       GenJnlLine1.RESET;
                       GenJnlLine1.COPY(GenJnlLine);
                       IF "Applies-to Doc. No." <> '' THEN
                           GenJnlLine1.SETRANGE("Applies-to Doc. No.", "Applies-to Doc. No.")
                       ELSE
                           GenJnlLine1.SETRANGE("Applies-to ID", "Applies-to ID");

                       GenJnlLine1.SETRANGE("Account Type", "Account Type"::Vendor);
                       IF ("Account Type" = "Account Type"::Vendor) OR ("Bal. Account Type" = "Bal. Account Type"::Vendor) OR
                          GenJnlLine1.FINDFIRST
                       THEN BEGIN
                           CurrFactor :=
                             CurrExchRate.ExchangeRate(
                               "Document Date", "Currency Code");
                           //   IF GenJnlLine1."Interest Amount" <> 0 THEN
                           //      GenJnlLine1.VALIDATE(Amount, GenJnlLine1.Amount - GenJnlLine1."Interest Amount");

                           IF IsPaymentOrRefund(GenJnlLine1) THEN
                               IF WHTPostingSetup.GET(GenJnlLine1."WHT Business Posting Group", GenJnlLine1."WHT Product Posting Group") THEN BEGIN
                                   IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                       IF GenJnlLine1.FINDFIRST THEN
                                           WHTManagement.CheckApplicationGenPurchWHT(GenJnlLine1);
                                       WHTAmountLCY :=
                                         CurrExchRate.ExchangeAmtFCYToLCY(
                                           "Document Date", "Currency Code",
                                           ABS(
                                             WHTManagement.CalcVendExtraWHTForEarliest(GenJnlLine1)), CurrFactor);
                                   END;

                                   IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment) AND
                                      (NOT GLSetup."Manual Sales WHT Calc.")
                                   THEN
                                       WHTAmountLCY :=
                                         CurrExchRate.ExchangeAmtFCYToLCY(
                                           GenJnlLine1."Document Date",
                                           GenJnlLine1."Currency Code",
                                           ABS(
                                             WHTManagement.WHTAmountJournal(GenJnlLine1, TRUE)), CurrFactor);
                               END;

                           IF "Document Type" = "Document Type"::Refund THEN
                               WHTAmountLCY := -ABS(WHTAmountLCY);
                       END;

                       //IF IsCustAcc(GenJnlLine) AND NOT GLSetup."Enable GST (Australia)" THEN BEGIN
                       IF IsCustAcc(GenJnlLine) THEN BEGIN
                           CurrFactor :=
                             CurrExchRate.ExchangeRate(
                               GenJnlLine1."Document Date", "Currency Code");
                           IF "Bal. Account Type" = "Bal. Account Type"::Customer THEN
                               GenJnlLine1.VALIDATE(Amount, -GenJnlLine1.Amount);

                           IF IsPaymentOrRefund(GenJnlLine1) THEN
                               IF WHTPostingSetup.GET(GenJnlLine1."WHT Business Posting Group", GenJnlLine1."WHT Product Posting Group") THEN BEGIN
                                   IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest) THEN BEGIN
                                       IF GenJnlLine1.FINDFIRST THEN
                                           WHTManagement.CheckApplicationGenSalesWHT(GenJnlLine1);
                                       WHTAmountLCY :=
                                         -CurrExchRate.ExchangeAmtFCYToLCY(
                                           GenJnlLine1."Document Date",
                                           GenJnlLine1."Currency Code",
                                           ABS(
                                             WHTManagement.CalcCustExtraWHTForEarliest(GenJnlLine1)), CurrFactor);
                                   END;

                                   IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment) AND
                                      (NOT GLSetup."Manual Sales WHT Calc.")
                                   THEN
                                       WHTAmountLCY :=
                                         -CurrExchRate.ExchangeAmtFCYToLCY(
                                           GenJnlLine1."Document Date",
                                           GenJnlLine1."Currency Code",
                                           ABS(WHTManagement.ApplyCustCalcWHT(GenJnlLine1)), CurrFactor);
                               END;

                           IF "Document Type" = "Document Type"::Refund THEN
                               WHTAmountLCY := ABS(WHTAmountLCY);
                       END;
                       WHTAmountLCY := ROUND(WHTAmountLCY);

                       IF GLSetup."Round Amount for WHT Calc" THEN
                           WHTAmountLCY := ROUND(WHTAmountLCY, 1, '<');
                   END ELSE
                       IF "Bank Payment Type" =
                          "Bank Payment Type"::"Computer Check"
                       THEN BEGIN
                           TESTFIELD("Check Printed", TRUE);
                           CheckLedgEntry.LOCKTABLE;
                           CheckLedgEntry.RESET;
                           CheckLedgEntry.SETCURRENTKEY("Bank Account No.", "Entry Status", "Check No.");
                           CheckLedgEntry.SETRANGE("Bank Account No.", "Account No.");
                           CheckLedgEntry.SETRANGE("Entry Status", CheckLedgEntry."Entry Status"::Printed);
                           CheckLedgEntry.SETRANGE("Check No.", "Document No.");
                           IF CheckLedgEntry.FIND('-') THEN
                               WHTAmountLCY := ABS(CheckLedgEntry."WHT Amount");
                       END;
           END;


       end;

       procedure CalcVendWHT(GenJnlLine: Record "Gen. Journal Line"; VAR WHTPostingSetup: Record "WHT Posting Setup"; VAR WHTAmountLCY: Decimal; VAR WHTAmount: Decimal)
       begin
           WITH GenJnlLine DO BEGIN
               WHTAmountLCY := 0;
               SourceCodeSetup.GET;
               IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN BEGIN
                   GenJnlLine1.RESET;
                   GenJnlLine1.COPY(GenJnlLine);
                   IF GLSetup."Enable WHT" THEN
                       IF NOT GenJnlLine1."Skip WHT" THEN
                           IF (GenJnlLine1."Applies-to Doc. No." = '') AND
                              (GenJnlLine1."Applies-to ID" = '')
                           THEN BEGIN
                               IF (((GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Invoice) OR
                                    (GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::"Credit Memo")) AND
                                   ((GenJnlLine1."Account Type" = GenJnlLine1."Account Type"::"G/L Account") OR
                                    (GenJnlLine1."Bal. Account Type" = GenJnlLine1."Bal. Account Type"::"G/L Account")))
                               THEN
                                   IF WHTPostingSetup.GET(GenJnlLine1."WHT Business Posting Group", GenJnlLine1."WHT Product Posting Group") THEN
                                       IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                                          (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                                       THEN BEGIN
                                           IF GenJnlLine1."WHT Absorb Base" <> 0 THEN
                                               WHTAmountLCY :=
                                                 -ROUND(
                                                   CurrExchRate.ExchangeAmtFCYToLCY(
                                                     "Posting Date", "Currency Code",
                                                     ROUND(GenJnlLine1."WHT Absorb Base" * WHTPostingSetup."WHT %" / 100), "Currency Factor"))
                                           ELSE
                                               WHTAmountLCY :=
                                                 ROUND(
                                                   CurrExchRate.ExchangeAmtFCYToLCY(
                                                     "Posting Date", "Currency Code",
                                                     ROUND(GenJnlLine1.Amount * WHTPostingSetup."WHT %" / 100), "Currency Factor"));
                                           WHTAmount := CalcDtldCVLedgEntryAmount(GenJnlLine, WHTPostingSetup."WHT %");
                                       END;
                           END ELSE
                               IF (((GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Invoice) OR
                                    (GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::"Credit Memo")) AND
                                   ((GenJnlLine1."Account Type" = GenJnlLine1."Account Type"::"G/L Account") OR
                                    (GenJnlLine1."Bal. Account Type" = GenJnlLine1."Bal. Account Type"::"G/L Account")))
                               THEN
                                   IF WHTPostingSetup.GET(GenJnlLine1."WHT Business Posting Group", GenJnlLine1."WHT Product Posting Group") THEN BEGIN
                                       IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                           GenJnlLine1.RESET;
                                           GenJnlLine1.COPY(GenJnlLine);
                                           IF GenJnlLine1.FINDFIRST THEN
                                               WHTManagement.CheckApplicationGenPurchWHT(GenJnlLine1);
                                           WHTAmountLCY := ROUND(WHTManagement.CalcVendExtraWHTForEarliest(GenJnlLine1));
                                           WHTAmount := WHTAmountLCY;
                                       END;

                                       IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice THEN BEGIN
                                           GenJnlLine1.RESET;
                                           GenJnlLine1.COPY(GenJnlLine);
                                           IF GenJnlLine1.FINDFIRST THEN
                                               WHTManagement.CheckApplicationGenPurchWHT(GenJnlLine1);
                                           IF GenJnlLine1."WHT Absorb Base" <> 0 THEN
                                               WHTAmountLCY :=
                                                 -ROUND(
                                                   CurrExchRate.ExchangeAmtFCYToLCY(
                                                     "Posting Date", "Currency Code",
                                                     ROUND(GenJnlLine1."WHT Absorb Base" * WHTPostingSetup."WHT %" / 100), "Currency Factor"))
                                           ELSE
                                               WHTAmountLCY :=
                                                 ROUND(
                                                   CurrExchRate.ExchangeAmtFCYToLCY(
                                                     "Posting Date", "Currency Code",
                                                     ROUND(GenJnlLine1.Amount * WHTPostingSetup."WHT %" / 100), "Currency Factor"));
                                           WHTAmount := CalcDtldCVLedgEntryAmount(GenJnlLine, WHTPostingSetup."WHT %");
                                       END;
                                   END;
                   IF GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Invoice THEN BEGIN
                       WHTAmountLCY := -ABS(WHTAmountLCY);
                       WHTAmount := -ABS(WHTAmount);
                   END ELSE BEGIN
                       WHTAmountLCY := ABS(WHTAmountLCY);
                       WHTAmount := ABS(WHTAmount);
                   END;
               END;

               IF WHTPostingSetup.GET("WHT Business Posting Group", "WHT Product Posting Group") THEN
                   IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN
                       IF Amount < WHTPostingSetup."WHT Minimum Invoice Amount" THEN
                           WHTAmountLCY := 0;
           END;
       end;

       procedure CalcDtldCVLedgEntryAmount(GenJnlLine: Record "Gen. Journal Line"; WHTPercent: Decimal): Decimal
       begin
           WITH GenJnlLine DO BEGIN
               IF "WHT Absorb Base" <> 0 THEN;
               ///     EXIT(ExchangeAmtLCYToFCY2(-ROUND("WHT Absorb Base" * WHTPercent / 100))); // pru sh
               //  EXIT(ExchangeAmtLCYToFCY2(ROUND(Amount * WHTPercent / 100))); // pru sh
           END;
       end;

/

       procedure PostVendWHT(GenJnlLine: Record "Gen. Journal Line"; VendLedgEntry: Record "Vendor Ledger Entry"; WHTPostingSetup: Record "WHT Posting Setup"; WHTAmountLCY: Decimal; WHTAmount: Decimal)

       begin
           WITH GenJnlLine DO BEGIN
               IF WHTAmountLCY <> 0 THEN
                   IF (GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::Invoice) OR
                      (GenJnlLine1."Document Type" = GenJnlLine1."Document Type"::"Credit Memo")
                   THEN
                       IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                          (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                       THEN
                           GenJNLpstLine.CreateGLEntry(
                             GenJnlLine, WHTPostingSetup."Payable WHT Account Code", WHTAmountLCY, WHTAmountLCY, TRUE);

               SourceCodeSetup.GET;
               IF "Source Code" <> SourceCodeSetup."Financially Voided Check" THEN BEGIN
                   GenJnlLine1.RESET;
                   IF GLSetup."Enable WHT" THEN
                       IF IsAboveWHTMinInvoiceAmount(GenJnlLine) THEN BEGIN
                           IF ("Applies-to Doc. No." <> '') OR ("Applies-to ID" <> '') THEN BEGIN
                               GenJnlLine1.COPY(GenJnlLine);
                               //  IF GenJnlLine1."Interest Amount" <> 0 THEN
                               //     GenJnlLine1.VALIDATE(Amount, GenJnlLine1.Amount - GenJnlLine1."Interest Amount");
                               IF NOT "Skip WHT" THEN BEGIN
                                   KeepWHTEntryNo := NextWHTEntryNo;
                                   CASE "Document Type" OF
                                       "Document Type"::"Credit Memo":
                                           BEGIN
                                               IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN
                                                   IF WHTPostingSetup.GET("WHT Business Posting Group", "WHT Product Posting Group") THEN
                                                       IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                                                          (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                                                       THEN BEGIN
                                                           GenJnlLine2.RESET;
                                                           GenJnlLine2.COPY(GenJnlLine);
                                                           GenJnlLine2.Amount := -ABS(GenJnlLine2.Amount);
                                                           GenJnlLine2."WHT Absorb Base" := -ABS(GenJnlLine2."WHT Absorb Base");
                                                           NextWHTEntryNo := WHTManagement.InsertVendJournalWHT(GenJnlLine2);
                                                           IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                               WHTEntry."Transaction No." := NextTransactionNo;
                                                               WHTEntry.MODIFY;
                                                           END;
                                                       END;
                                               IF SourceCodeSetup.Purchases = "Source Code" THEN
                                                   UpdateWHTEntryTransaction("Document No.");
                                           END;
                                       "Document Type"::Payment:
                                           IF WHTPostingSetup.GET("WHT Business Posting Group", "WHT Product Posting Group") THEN BEGIN
                                               IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
                                                   NextWHTEntryNo := WHTManagement.ApplyVendInvoiceWHT(VendLedgEntry, GenJnlLine1);
                                                   IF NextWHTEntryNo <> -1 THEN
                                                       HadWHTEntryNo := TRUE
                                                   ELSE
                                                       NextWHTEntryNo := KeepWHTEntryNo;
                                               END;
                                               IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                                   NextWHTEntryNo := WHTManagement.InsertVendJournalWHT(GenJnlLine);
                                                   IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                       WHTEntry."Transaction No." := NextTransactionNo;
                                                       WHTEntry.MODIFY;
                                                   END;
                                               END;
                                           END;
                                       "Document Type"::Refund:
                                           IF GLSetup."Manual Sales WHT Calc." THEN BEGIN
                                               IF "WHT Payment" THEN
                                                   NextWHTEntryNo := WHTManagement.ProcessManualReceipt(
                                                       GenJnlLine1, VendLedgEntry."Transaction No.", VendLedgEntry."Entry No.", 0);
                                           END ELSE
                                               IF WHTPostingSetup.GET("WHT Business Posting Group", "WHT Product Posting Group") THEN BEGIN
                                                   IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
                                                       NextWHTEntryNo := WHTManagement.ApplyVendInvoiceWHT(VendLedgEntry, GenJnlLine1);
                                                       IF NextWHTEntryNo <> -1 THEN
                                                           HadWHTEntryNo := TRUE
                                                       ELSE
                                                           NextWHTEntryNo := KeepWHTEntryNo;
                                                   END;
                                                   IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                                       NextWHTEntryNo := WHTManagement.InsertVendJournalWHT(GenJnlLine);
                                                       IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                           WHTEntry."Transaction No." := NextTransactionNo;
                                                           WHTEntry.MODIFY;
                                                       END;
                                                   END;
                                               END;
                                       "Document Type"::Invoice:
                                           BEGIN
                                               IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN
                                                   IF WHTPostingSetup.GET("WHT Business Posting Group", "WHT Product Posting Group") THEN
                                                       IF (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Invoice) OR
                                                          (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest)
                                                       THEN BEGIN
                                                           GenJnlLine2.RESET;
                                                           GenJnlLine2.COPY(GenJnlLine);
                                                           GenJnlLine2.Amount := -ABS(GenJnlLine2.Amount);
                                                           GenJnlLine2."WHT Absorb Base" := -ABS(GenJnlLine2."WHT Absorb Base");
                                                           NextWHTEntryNo := WHTManagement.InsertVendJournalWHT(GenJnlLine2);
                                                           IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                               WHTEntry."Transaction No." := NextTransactionNo;
                                                               WHTEntry.MODIFY;
                                                           END;
                                                       END;
                                               IF SourceCodeSetup.Purchases = "Source Code" THEN
                                                   UpdateWHTEntryTransaction("Document No.");
                                           END;
                                   END;
                               END;

                               TempGenJnlTemp.SETRANGE(Type, TempGenJnlTemp.Type::Purchases);
                               IF TempGenJnlTemp.FINDFIRST THEN
                                   IF "Journal Template Name" = TempGenJnlTemp.Name THEN BEGIN
                                       WHTEntry.RESET;
                                       WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Payment);
                                       WHTEntry.SETRANGE("Document No.", "Document No.");
                                       WHTEntry.SETRANGE("Bill-to/Pay-to No.", "Account No.");
                                       IF WHTEntry.FIND('-') THEN
                                           REPEAT
                                               WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group");
                                               WHTPostingSetup.TESTFIELD("Payable WHT Account Code");
                                               GenJNLpstLine.CreateGLEntry(
                                                 GenJnlLine, WHTPostingSetup."Payable WHT Account Code", -WHTEntry."Amount (LCY)", "Source Currency Amount", TRUE);
                                           UNTIL WHTEntry.NEXT = 0;
                                   END;
                           END ELSE BEGIN
                               KeepWHTEntryNo := NextWHTEntryNo;
                               CASE "Document Type" OF
                                   "Document Type"::Invoice,
                                   "Document Type"::"Credit Memo":
                                       BEGIN
                                           IF ProcessSourceCode("Source Code", SourceCodeSetup) THEN BEGIN
                                               GenJnlLine2.RESET;
                                               GenJnlLine2.COPY(GenJnlLine);
                                               GenJnlLine2."WHT Absorb Base" := -ABS(GenJnlLine2."WHT Absorb Base");
                                               NextWHTEntryNo := WHTManagement.InsertVendJournalWHT(GenJnlLine2);
                                           END;
                                           UpdateWHTEntryTransaction("Document No.");
                                       END;
                                   "Document Type"::Payment,
                                 "Document Type"::Refund:
                                       IF WHTPostingSetup.GET("WHT Business Posting Group", "WHT Product Posting Group") THEN
                                           IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Earliest THEN BEGIN
                                               NextWHTEntryNo := WHTManagement.InsertVendJournalWHT(GenJnlLine);
                                               IF WHTEntry.GET(NextWHTEntryNo - 1) THEN BEGIN
                                                   WHTEntry."Transaction No." := NextTransactionNo;
                                                   WHTEntry.MODIFY;
                                               END;
                                           END;
                                   "Document Type"::" ":
                                       NextWHTEntryNo := KeepWHTEntryNo;
                               END;
                           END;
                           IF NextWHTEntryNo = 0 THEN
                               NextWHTEntryNo := KeepWHTEntryNo;

                           PostVendWHTTaxInv(GenJnlLine, VendLedgEntry);
                       END;

                   IF "Applies-to ID" <> '' THEN BEGIN
                       VendLedgEntry.RESET;
                       VendLedgEntry.SETCURRENTKEY("Vendor No.", "Applies-to ID", Open, Positive, "Due Date");
                       VendLedgEntry.SETRANGE("Vendor No.", "Account No.");
                       VendLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                       VendLedgEntry.SETRANGE("Amount to Apply", 0);
                       VendLedgEntry.MODIFYALL("Applies-to ID", '');
                   END;
               END;
           END;
       end;
   */
    /*  local procedure BankAccountCustomValidationsNavone(BankAccountNo: Code[20]; BalanceLcy: Decimal)
      var
          TempBankAccount: Record 270 temporary;
          BankAccount: Record 270;
          BankBalance: Decimal;
          CurrBalance: Decimal;
      begin
          //>>BBV_0.1 PRU_RPG
          TempBankAccount.DELETEALL;
          TempBankAccount.RESET;
          TempBankAccount.SETRANGE("No.", BankAccountNo);
          IF NOT TempBankAccount.FINDFIRST THEN BEGIN
              TempBankAccount.INIT;
              TempBankAccount."No." := BankAccountNo;
              IF (BalanceLcy > 0) THEN
                  TempBankAccount."Max Balance" := TempBankAccount."Max Balance" - BalanceLcy
              ELSE
                  TempBankAccount."Max Balance" := TempBankAccount."Max Balance" + ABS(BalanceLcy);
              TempBankAccount.INSERT;
          END ELSE BEGIN
              IF (BalanceLcy > 0) THEN
                  TempBankAccount."Max Balance" := TempBankAccount."Max Balance" - BalanceLcy
              ELSE
                  TempBankAccount."Max Balance" := TempBankAccount."Max Balance" + ABS(BalanceLcy);
              TempBankAccount.MODIFY;
          END;

          TempBankAccount.RESET;
          IF TempBankAccount.FINDSET THEN BEGIN
              REPEAT
                  CLEAR(BankBalance);
                  BankAccount.RESET;
                  BankAccount.SETRANGE("No.", TempBankAccount."No.");
                  IF BankAccount.FINDSET THEN BEGIN
                      BankAccount.CALCFIELDS("Balance (LCY)");
                      BankBalance := BankAccount."Balance (LCY)";
                      CLEAR(CurrBalance);
                      CurrBalance := TempBankAccount."Max Balance";
                      CurrBalance += BankBalance;

                      IF (BankAccount."Max Balance" > 0) THEN
                          IF (CurrBalance > BankAccount."Max Balance") THEN
                              IF (CurrBalance > BankBalance) THEN BEGIN
                                  ERROR(STRSUBSTNO('Bank account %1 maximum balance limit %2 is exceeding by %3', BankAccount."No.", BankAccount."Max Balance", ((TempBankAccount."Max Balance" + BankBalance) - BankAccount."Max Balance")));
                              END;

                      IF (CurrBalance < BankAccount."Min Balance") THEN
                          IF (CurrBalance < BankBalance) THEN BEGIN
                              ERROR(STRSUBSTNO('Minnimum balance %1 of Bank account %2 has reached below by %3', BankAccount."Min Balance", BankAccount."No.", ((TempBankAccount."Max Balance" + BankBalance) - BankAccount."Min Balance")));
                          END;

                      IF (BankAccount."Per Trans. Withdrawal Limit" > 0) AND (CurrBalance < BankBalance) THEN
                          IF (ABS(TempBankAccount."Max Balance") > BankAccount."Per Trans. Withdrawal Limit") THEN BEGIN
                              ERROR(STRSUBSTNO('Amount %1 is more than per transaction withdrawl limit %2 by bank %3', TempBankAccount."Max Balance", BankAccount."Per Trans. Withdrawal Limit", BankAccount."No."));
                          END;

                  END;
              UNTIL TempBankAccount.NEXT = 0;
          END;

      end;
  */
    procedure PostVendWHTTaxInv(GenJnlLine: Record "Gen. Journal Line"; VendLedgEntry: Record "Vendor Ledger Entry")
    begin

        /*    
        IF NOT GLSetup."Enable Tax Invoices" THEN
          EXIT;

        IF (GenJnlLine."Applies-to Doc. No." <> '') OR (GenJnlLine."Applies-to ID" <> '') THEN BEGIN
          CASE GenJnlLine."Document Type" OF
            GenJnlLine."Document Type"::Payment:
              TaxManagement.ApplyVendInvoiceWHT(VendLedgEntry,GenJnlLine1);
            GenJnlLine."Document Type"::Refund:
              TaxManagement.ApplyVendCreditWHT(VendLedgEntry,GenJnlLine1);
          END;
        END ELSE BEGIN
          PurchSetup.GET;
          ReportSelection.RESET;
          ReportSelection.SETRANGE(Usage,ReportSelection.Usage::"P.TaxInvoice");
          IF ReportSelection.FIND('-') THEN
            REPEAT
              PurchTaxInvHeader.SETRANGE("No.",GenJnlLine."Document No.");
              IF PurchTaxInvHeader.FINDFIRST THEN
                REPORT.RUN(ReportSelection."Report ID",PurchSetup."Print Dialog",FALSE,PurchTaxInvHeader);
            UNTIL ReportSelection.NEXT = 0;
        END;
        */
        /*  end;

          procedure PostCustWHTTaxInv(GenJnlLine: Record "Gen. Journal Line"; CustLedgEntry: Record "Cust. Ledger Entry")
          begin

              /*
              IF GLSetup."Enable Tax Invoices" THEN
                IF (GenJnlLine."Applies-to Doc. No." <> '') OR (GenJnlLine."Applies-to ID" <> '') THEN BEGIN
                  CASE GenJnlLine."Document Type" OF
                    GenJnlLine."Document Type"::Payment:
                      TaxManagement.ApplyCustInvoiceWHT(CustLedgEntry,GenJnlLine);
                    GenJnlLine."Document Type"::Refund:
                      TaxManagement.ApplyCustCreditWHT(CustLedgEntry,GenJnlLine);
                  END;
                END ELSE BEGIN
                  SalesSetup.GET;
                  ReportSelection.RESET;
                  ReportSelection.SETRANGE(Usage,ReportSelection.Usage::"S.TaxInvoice");
                  IF ReportSelection.FIND('-') THEN
                    REPEAT
                      SalesTaxInvHeader.SETRANGE("No.",GenJnlLine."Document No.");
                      IF SalesTaxInvHeader.FINDFIRST THEN
                        REPORT.RUN(ReportSelection."Report ID",SalesSetup."Print Dialog",FALSE,SalesTaxInvHeader);
                    UNTIL ReportSelection.NEXT = 0;
                END;
              */
    end;

    /*  procedure IsCustAcc(GenJnlLine: Record "Gen. Journal Line"): Boolean
      begin
          WITH GenJnlLine DO
              EXIT(("Account Type" = "Account Type"::Customer) OR ("Bal. Account Type" = "Account Type"::Customer));
      end;

      procedure IsVendAcc(GenJnlLine: Record "Gen. Journal Line"): Boolean
      begin
          WITH GenJnlLine DO
              EXIT(("Account Type" = "Account Type"::Vendor) OR ("Bal. Account Type" = "Account Type"::Vendor));
      end;

      procedure IsPaymentOrRefund(GenJnlLine: Record "Gen. Journal Line"): Boolean
      begin
          WITH GenJnlLine DO
              EXIT("Document Type" IN ["Document Type"::Payment, "Document Type"::Refund]);
      end;
      /*
          procedure GenJNLpstLine.CreateGLEntry(GenJnlLine: Record "Gen. Journal Line"; AccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; UseAmountAddCurr: Boolean)
          begin
              IF UseAmountAddCurr THEN
                  InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, AmountAddCurr, TRUE, TRUE)
              ELSE BEGIN
                  InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, 0, FALSE, TRUE);
                  GLEntry."Additional-Currency Amount" := AmountAddCurr;
              END;
              InsertGLEntry(GenJnlLine, GLEntry, TRUE);
          end;


      procedure ProcessSourceCode(SourceCode: Code[10]; SourceCodeSetup: Record "Source Code Setup"): Boolean
      begin
          EXIT(SourceCode IN [SourceCodeSetup."Payment Journal",
                              SourceCodeSetup."Purchase Journal",
                              SourceCodeSetup."Sales Journal",
                              SourceCodeSetup."Cash Receipt Journal",
                              SourceCodeSetup."General Journal"]);
      end;

  */
    procedure IncreaseWHTEntryNo()
    begin
        NextWHTEntryNo := NextWHTEntryNo + 1;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        GenJnlLine1: Record "Gen. Journal Line";
        CurrFactor: Decimal;
        WHTManagement: Codeunit WHTManagement;
        CurrExchRate: Record "Currency Exchange Rate";
        SourceCodeSetup: Record "Source Code Setup";
        KeepWHTEntryNo: Integer;
        NextWHTEntryNo: Integer;
        HadWHTEntryNo: Boolean;
        WHTEntry: Record "WHT Entry";
        NextTransactionNo: Integer;
        GenJnlLine2: Record "Gen. Journal Line";
        WHTPostingSetup: Record "WHT Posting Setup";
        TempGenJnlTemp: Record "Gen. Journal Template";
        BankAcc: Record "Bank Account";
        BankAccPostingGr: Record "Bank Account Posting Group";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        NextEntryNo: Integer;
        WHTAmountLCY: Decimal;
        WHTAmount: Decimal;
        CheckLedgEntry: Record "Check Ledger Entry";
        GenJNLpstLine: codeunit "Gen. Jnl.-Post Line";
}