pageextension 50011 ItemJournalExt extends "Item Journal"
{
    layout
    {
        addafter(Amount)
        {

        }
    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Item Journal", '<>%1', UserSetup."Access Item Journal"::Post);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Item Journal')
            end;
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Item Journal');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::Post);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Item Journal');
        //ERROR('You do not have Permission to Delete Purchase Quote');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //  ERROR('You do not have Permission to Change Purchase Quote Details');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //    ERROR('You do not have Permission to Change Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);


        //   ERROR('You do not have Permission to add new Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Item Journal');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;



    var
        UserSetup: Record 91;
        //   DimensionMaster: Record "Dimension Master";
        ItemJn: Record 83;
        DimnErr: Label 'Dimension Master Does not exist for Document No %1 and Line No. %2.';
        Dimenstiounedit: Boolean;
        CurrentJnlBatchName: Text[50];

}



