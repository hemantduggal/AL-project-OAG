page 50065 Cateringreqdropdown
{
    PageType = List;
    Caption = 'Catering Requistion Purpose List';
    UsageCategory = Administration;
    // ApplicationArea = all;
    SourceTable = cateringdropdown;

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