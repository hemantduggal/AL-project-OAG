table 50015 "Purchase Requisition Line"
{
    DataClassification = ToBeClassified;
    Caption = 'Purchase Requisition Line';

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            // AutoIncrement = true;
        }
        field(2; "Requisition Slip No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; Type; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
            OptionCaption = ' ,Item,Fixed Asset,G/L Account';
            OptionMembers = " ",Item,"Fixed Asset","G/L Account";

        }
        field(4; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account";

            trigger OnValidate()
            var
                RecItem: Record Item;
                REQH: Record "purchase Requisition Header";
            begin
                IF RecItem.GET("No.") THEN begin
                    Description := RecItem.Description;
                    "Unit Cost" := RecItem."Unit Cost";
                end;

                "Unit Of Measure Code" := RecItem."Base Unit of Measure";
                REQH.Get(rec."Requisition Slip No.");
                Rec."Store Location" := REQH."Store Location";
                rec."Location Code" := REQH."Location Code";

            end;

            /*  trigger OnValidate()
    var
        RecItem: Record Item;
    begin
        If (Rec.Type = Rec.Type::Item) then begin
            Message('a');
            Message('%1', Rec."No.");
            RecItem.SetRange("No.", Rec."No.");
            if RecItem.FindFirst() then begin
                rec."Stock In Hand" := RecItem.Inventory;
                Message('%1', RecItem.Inventory);
            end;
        end;
    end;*/
        }

        field(5; Description; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Unit Of Measure Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Request Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.Amount := Rec."Request Quantity" * Rec."Unit Cost";
                if "Post Issue Qty" <> 0 then
                    Error('You can not change Request Quantity');
            end;
        }
        field(8; "Issued Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Post Issue Qty" = "Request Quantity" then
                    Error('You can not issue Quantity');
                if "Issued Quantity" > "Request Quantity" then
                    Error('You can not Issued Quantity more then Request Quantity');

            end;
        }
        field(9; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Amount := "Request Quantity" * "Unit Cost";
            end;
        }
        field(10; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Comment"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Store Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Stock In Hand"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = field("No."), "Location Code" = field("Store Location")));

        }
        field(14; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(15; "Post Issue Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Requisition Slip No.", "Line No.")
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