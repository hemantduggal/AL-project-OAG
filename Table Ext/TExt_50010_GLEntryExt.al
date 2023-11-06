tableextension 50010 GLEntryExt extends "G/L Entry"
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