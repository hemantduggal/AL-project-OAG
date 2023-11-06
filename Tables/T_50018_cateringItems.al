table 50018 CateringItems
{
    Caption = 'Catering Items';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; Item_code; Code[30])
        {
            Caption = 'Item Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; UnitCost; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
}