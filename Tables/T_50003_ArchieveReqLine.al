table 50003 "Archieve Req_Line"
{
    DataClassification = ToBeClassified;
    Caption = 'Archieve Req_Line';

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
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
        }
        field(8; "Issued Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Amount := "Issued Quantity" * "Unit Cost";
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