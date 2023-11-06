report 50017 "Item dlt"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'delete item ';
    Permissions = tabledata Item = rmd;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";
            trigger OnAfterGetRecord()
            begin
                item.Delete();
            end;
        }
    }
}