page 50032 approvedRequisitionList
{
    PageType = List;
    Caption = 'Approved Requisition List';
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = "Requisition Header";
    CardPageId = "ApprovedRequisitionCard";
    Editable = false;
    SourceTableView = sorting("Requisition Slip No.") order(descending) where(Status = filter('Approved'));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Requisition Slip No."; Rec."Requisition Slip No.")
                {
                    ApplicationArea = All;
                }
                field("Requested User ID"; Rec."Requested User ID")
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(get)
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    edms: Codeunit edmsintegration;
                begin
                    edms.GetMethod();
                end;
            }
            action(upload)
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    edms: Codeunit edmsintegration;
                begin
                    edms.UploadMethod();
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Requisition Document');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Requisition Document Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;


    /*  trigger OnOpenPage()
      begin

          //PRU_DD 1.10
          UserSetup.RESET;
          UserSetup.SETRANGE("User ID", USERID);
          UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::" ");
          IF UserSetup.FINDFIRST THEN
              ERROR('You do not have permission to open Requisition Order');

          UserSetup.RESET;
          UserSetup.SETRANGE("User ID", USERID);
          UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::View);
          IF UserSetup.FINDFIRST THEN
              CurrPage.EDITABLE(FALSE);

          UserSetup.RESET;
          UserSetup.SETRANGE("User ID", USERID);
          UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::Edit);
          IF UserSetup.FINDFIRST THEN
              CurrPage.EDITABLE(true);

          UserSetup.RESET;
          UserSetup.SETRANGE("User ID", USERID);
          UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::Create);
          IF UserSetup.FINDFIRST THEN
              CurrPage.EDITABLE(true);
      end;
  */
    var
        RecItem: Record Item;
        UserSetup: Record 91;
}