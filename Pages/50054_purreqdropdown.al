page 50064 Purreqdropdown
{
    PageType = List;
    Caption = 'Purchase Requistion Purpose List';
    UsageCategory = Administration;
    // ApplicationArea = all;
    SourceTable = purreqdropdown;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}