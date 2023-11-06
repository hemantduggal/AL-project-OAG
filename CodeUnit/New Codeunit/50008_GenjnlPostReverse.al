codeunit 50008 GenjnlPostReverse
{
    var
        Number: Integer;
        NewNumber: Integer;
        WHTEntry: Record 50011;
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        NewDtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    // C50002: Codeunit 50002;

    [EventSubscriber(ObjectType::Codeunit, 17, 'OnBeforeReverse', '', false, false)]

    local procedure OnBeforeReverse(var ReversalEntry: Record 179; var ReversalEntry2: Record 179; var IsHandled: Boolean)
    begin
        //>>PRU_RPG WHT_0.1
        IF ReversalEntry2."Reversal Type" = ReversalEntry2."Reversal Type"::Transaction THEN
            IF ReversalEntry2.FINDSET THEN BEGIN
                Number := ReversalEntry2."Transaction No.";
                NewNumber := Number;
                REPEAT
                    IF Number <> ReversalEntry2."Transaction No." THEN
                        NewNumber := ReversalEntry2."Transaction No."
                UNTIL ReversalEntry2.NEXT = 0;
                IF Number <> NewNumber THEN BEGIN
                    WHTEntry.SETFILTER("Transaction No.", '%1|%2', Number, NewNumber);
                    BankAccLedgEntry.SETFILTER("Transaction No.", '%1|%2', Number, NewNumber);
                END;
            END;

        //<<PRU_RPG WHT_0.1/
    end;

    [EventSubscriber(ObjectType::Codeunit, 17, 'OnReverseCustLedgEntryOnBeforeInsertCustLedgEntry', '', false, false)]

    local procedure OnReverseCustLedgEntryOnBeforeInsertCustLedgEntry(var NewCustLedgerEntry: Record 21; CustLedgerEntry: Record 21)
    begin
        //>>SDV_0.1 PRU_RPG
        IF NewDtldCustLedgEntry."Entry Type" = NewDtldCustLedgEntry."Entry Type"::"Initial Entry" THEN BEGIN
            ///  C50002.CheckReverseCustPaymentForBlankLine(NewDtldCustLedgEntry);
            // C50002.CheckReverseCustPaymentRefundforBlankLine(NewDtldCustLedgEntry);
        END;
        //<<SDV_0.1 PRU_RPG
    end;
}