page 50063 storereqdropdown
{
    PageType = List;
    Caption = 'Store Requistion Purpose List';
    UsageCategory = Administration;
    // ApplicationArea = all;
    SourceTable = storedropdown;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Store Requisition Purpose"; Rec."Store Requisition Purpose")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}