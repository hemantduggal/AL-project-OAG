table 50020 "Catering Lines"
{
    DataClassification = ToBeClassified;
    Caption = 'Catering Lines';

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; DocNo; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; CateringItem; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = CateringItems.Item_code;
            trigger OnValidate()
            var
                catItem: Record CateringItems;
            begin
                if catItem.Get(Rec.CateringItem) then begin
                    Description := catItem.Description;
                    UnitCost := catItem.UnitCost;
                end;
            end;
        }
        field(4; Description; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; UnitCost; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; quantity; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Amount := UnitCost * quantity * NoOfDays;
            end;
        }
        field(7; NoOfDays; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Amount := UnitCost * quantity * NoOfDays;
            end;
        }
        field(8; servingTime; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Amount; Decimal)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }
}