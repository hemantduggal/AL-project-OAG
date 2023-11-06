page 50040 "Catering Item list"
{
    Caption = 'Catering Item list';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = CateringItems;

    layout
    {
        area(Content)
        {

            repeater("General")
            {
                field(Item_code; Rec.Item_code)
                {
                    Caption = 'Item Code';
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(UnitCost; Rec.UnitCost)
                {
                    Caption = 'Unit Cost';
                    ApplicationArea = all;
                }
            }
        }
    }
}