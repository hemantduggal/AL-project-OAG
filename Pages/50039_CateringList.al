page 50039 "Catering Requistion List"
{
    CardPageId = "Catering Card";
    Caption = 'Catering Requistion List';
    PageType = List;
    Editable = false;
    DeleteAllowed = true;
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = "Catering Header";
    SourceTableView = sorting("No.") order(descending) where(Status = filter(Open | "Pending for Approval"));

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
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}