page 50004 "Archieve Req Card"
{
    Caption = 'Archieve Requisition Card';
    PageType = Card;
    //   UsageCategory = Administration;
    // ApplicationArea = all;
    PopulateAllFields = true;
    SourceTable = "Archieve Req Header";
    // Editable = false;
    layout
    {
        area(Content)
        {

            group("General")
            {
                Caption = 'General';
                field("Requisition Slip No."; Rec."Requisition Slip No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnAssistEdit()
                    begin
                        // if rec.AssistEdit(xRec) then
                        //     CurrPage.Update(false);
                    end;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Subject Matter';//neha11-11-22
                }
                field("Requested User ID"; rec."Requested User ID")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Request Date"; rec."Request Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Acknol_comment; Rec.Acknol_comment)
                {
                    ApplicationArea = all;
                    caption = 'Acknowledgment Comment';
                    Editable = edit;
                }

                field(Status; rec.Status)
                {
                    Editable = false;

                    ApplicationArea = all;
                }
                field("Short Close"; Rec."Short Close")
                {
                    Editable = false;

                    ApplicationArea = all;
                }
                field(Department; rec.Department)
                {
                    Editable = false;

                    ApplicationArea = all;
                    ShowMandatory = true;  //neha11-11-22
                }
                field("1st Approved/Rejected User ID"; rec."1st Approved/Rejected User ID")
                {
                    Editable = false;

                    ApplicationArea = all;
                    ShowMandatory = true;  //neha11-11-22
                }
                field("1st Approved/Rejected Date"; rec."1st Approved/Rejected Date")
                {
                    Editable = false;

                    ApplicationArea = all;
                }
                field("1st Reject Comment"; rec."1st Reject Comment")
                {
                    Editable = false;

                    ApplicationArea = all;
                }
                field("2nd Approver"; rec."2nd Approver")
                {
                    Editable = false;

                    ApplicationArea = all;
                    Visible = false; //neha11-11-22
                }
                field("2nd Approved/Rejected User ID"; rec."2nd Approved/Rejected User ID")
                {
                    Editable = false;

                    ApplicationArea = all;
                }
                field("2nd Approved/Rejected Date"; rec."2nd Approved/Rejected Date")
                {
                    Editable = false;

                    ApplicationArea = all;
                }
                field("2nd Reject Comment"; rec."2nd Reject Comment")
                {
                    Editable = false;


                    ApplicationArea = all;
                }
                field("Store Location"; rec."Store Location")
                {
                    ApplicationArea = all;
                    editable = false;
                    ShowMandatory = true;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Reference No."; Rec."Reference No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
            }

            group("Lines")
            {
                Caption = 'Lines';
                part(RequisitionLine; "Archieve Req SubForm")
                {
                    Editable = false;
                    SubPageLink = "Requisition Slip No." = FIELD("Archive Requisition Slip No.");
                    ApplicationArea = All;
                }
            }

        }
    }
    trigger OnOpenPage()
    var
        usersetup: Record "User Setup";
    begin
        if UserId = Rec."Requested User ID" then
            edit := true
        else
            edit := false;
    end;

    var
        edit: Boolean;

}

