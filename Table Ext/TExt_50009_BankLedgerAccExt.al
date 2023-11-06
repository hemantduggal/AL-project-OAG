tableextension 50009 BankAccLedgerExt extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50000; "EFT/Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'EFT/Document No.';
        }
    }
}