page 50038 "Catering SubForm"
{
    PageType = ListPart;
    //UsageCategory = Administration;
    PopulateAllFields = true;
    //ApplicationArea = all;
    SourceTable = "Catering Lines";
    Caption = 'Catering SubForm';
    AutoSplitKey = true;
    Editable = true;
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
                field(DocNo; Rec.DocNo)
                {

                }
                field(CateringItem; Rec.CateringItem)
                {
                    Caption = 'Item';
                    ApplicationArea = all;
                    LookupPageId = "Catering Item list";
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
                field(quantity; Rec.quantity)
                {
                    Caption = 'Quntity';
                    ApplicationArea = all;
                }
                field(NoOfDays; Rec.NoOfDays)
                {
                    Caption = 'No. of Days';
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field(servingTime; Rec.servingTime)
                {
                    Caption = 'Time to Serve';
                    ApplicationArea = all;
                }
            }
        }
    }
}