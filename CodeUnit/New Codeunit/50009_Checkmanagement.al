codeunit 50009 Checkhmanagement
{
    [EventSubscriber(ObjectType::Codeunit, 367, 'OnBeforeFinancialVoidCheck', '', false, false)]

    local procedure OnBeforeFinancialVoidCheck(var CheckLedgerEntry: Record 272)
    var
        AmountToVoid: Decimal;
        CheckLedgEntry: Record "Check Ledger Entry";
        WHTAmount: Decimal;
    begin
        AmountToVoid := CalcAmountToVoid(CheckLedgEntry, WHTAmount);  //PRU_RPG WHT_0.1
    end;

    local procedure CalcAmountToVoid(CheckLedgEntry: Record 272; var WHTAmount: Decimal) AmountToVoid: Decimal
    var
        CheckLedgEntry2: Record 272;
    begin
        WITH CheckLedgEntry2 DO BEGIN
            RESET;
            SETRANGE("Bank Account No.", CheckLedgEntry."Bank Account No.");
            SETRANGE("Entry Status", CheckLedgEntry."Entry Status"::Posted);
            SETRANGE("Statement Status", CheckLedgEntry."Statement Status"::Open);
            SETRANGE("Check No.", CheckLedgEntry."Check No.");
            SETRANGE("Check Date", CheckLedgEntry."Check Date");
            //  CALCSUMS(Amount);
            //  AmountToVoid := Amount;
            CALCSUMS(Amount, "WHT Amount"); //PRU_RPG WHT_0.1
            AmountToVoid := Amount;  //PRU_RPG WHT_0.1
            WHTAmount := "WHT Amount";  //PRU_RPG WHT_0.1
        END;

    end;

    [EventSubscriber(ObjectType::Codeunit, 367, 'OnFinancialVoidCheckOnBeforePostVend', '', false, false)]

    local procedure OnFinancialVoidCheckOnBeforePostVend(var GenJournalLine: Record 81; var VendorLedgerEntry: Record 25; var BalanceAmountLCY: Decimal)
    begin
    end;

}