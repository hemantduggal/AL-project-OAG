page 50007 "Terms & Cond Page"
{
    PageType = List;
    Caption = 'Terms & Condition';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Terms and  Condition";
    //  Editable = false;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."AccessPOTerms&ConditionMaster", '%1', UserSetup."AccessPOTerms&ConditionMaster"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."AccessPOTerms&ConditionMaster", '%1', UserSetup."AccessPOTerms&ConditionMaster"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open PO Terms & Condition Master');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."AccessPOTerms&ConditionMaster", '%1', UserSetup."AccessPOTerms&ConditionMaster"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."AccessPOTerms&ConditionMaster", '%1', UserSetup."AccessPOTerms&ConditionMaster"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change PO Terms & Condition Master Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."AccessPOTerms&ConditionMaster", '%1', UserSetup."AccessPOTerms&ConditionMaster"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;

}