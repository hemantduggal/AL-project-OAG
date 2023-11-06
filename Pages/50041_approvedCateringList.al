page 50041 "Approved Catering List"
{
    CardPageId = "Catering Card";
    Caption = 'Approved Catering Requistion List';
    PageType = List;
    Editable = false;
    DeleteAllowed = true;
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = "Catering Header";
    SourceTableView = sorting("No.") order(descending) where(Status = filter(Approved));

    layout
    {
        area(Content)
        {

            repeater(GroupName)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Venue; Rec.Venue)
                {
                    Caption = 'Confirmed Venue';
                    ApplicationArea = all;
                }
                field(meetingdate; Rec.meetingdate)
                {
                    ApplicationArea = all;
                    Caption = 'Meeting Date';
                }
                field(meetingTime; Rec.meetingTime)
                {
                    ApplicationArea = all;
                    Caption = 'Meeting Time';
                }
            }
        }
    }
}