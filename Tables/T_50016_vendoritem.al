table 50016 "Vendor item relation"
{
    DataClassification = ToBeClassified;
    Caption = 'vendor item relation';

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            // AutoIncrement = true;
        }
        field(2; "item no."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
            trigger OnValidate()
            var
                itm: Record Item;
            begin
                if itm.get(Rec."item no.") then begin
                    description := itm.Description;
                    UOM := itm."Base Unit of Measure";
                end;
            end;

        }
        field(3; "vendor no."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(4; description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; UOM; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }


    keys
    {
        key(Key1; "item no.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        ItemRec: Record Item;
        ae: Record "Purchase Line";

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}