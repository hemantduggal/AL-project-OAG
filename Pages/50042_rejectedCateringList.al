page 50042 "Rejected Catering List"
{
    CardPageId = "Catering Card";
    Caption = 'Rejected Catering Requistion List';
    PageType = List;
    Editable = false;
    DeleteAllowed = true;
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = "Catering Header";
    SourceTableView = sorting("No.") order(descending) where(Status = filter(Rejected | "Short Close"));

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