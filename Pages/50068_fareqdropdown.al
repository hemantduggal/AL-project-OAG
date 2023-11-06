page 50068 FAreqdropdown
{
    PageType = List;
    Caption = 'Purchase Requistion Purpose List';
    UsageCategory = Administration;
    // ApplicationArea = all;
    SourceTable = fastoredropdown;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Purpose; Rec."Store Requisition Purpose")
                {
                    Caption = 'FA Requisition Purpose';
                    ApplicationArea = All;
                }
            }
        }
    }
}