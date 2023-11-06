page 50031 vendoritemrelation
{
    PageType = List;
    UsageCategory = Administration;
    PopulateAllFields = true;
    ApplicationArea = all;
    SourceTable = "vendor item relation";
    Caption = 'Vendor-item Catalog';
    AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Line No."; Rec."Line No.")
                {
                    // ApplicationArea = all;
                    Editable = false;
                }
                field("Item No."; Rec."item no.")
                {
                    Caption = 'Item No.';
                    ApplicationArea = all;
                }
                field(Description; Rec.description)
                {
                    Caption = 'Descritpion';
                    ApplicationArea = all;
                }
                field(UOM; Rec.UOM)
                {
                    Caption = 'Unit of Measure';
                    ApplicationArea = all;
                }
                field("Vendor No."; Rec."vendor no.")
                {
                    Caption = 'Vendor No.';
                    ApplicationArea = all;
                    // Editable = false;
                }
                field(vendname; vendname)
                {
                    Caption = 'Name';
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }
    var
        vendname: Text[100];
        vend: Record Vendor;

    trigger OnAfterGetRecord()
    begin
        Clear(vendname);
        vend.Init();
        if vend.Get(Rec."vendor no.") then begin
            vendname := vend.Name;
        end;
    end;
}