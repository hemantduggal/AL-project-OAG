pageextension 50079 PhysInventoryJournalExt extends "Phys. Inventory Journal"
{
    layout
    {
    }
    actions
    {
        modify("P&ost")
        {
            trigger OnBeforeAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Phys.Inventory Journals", '<>%1', UserSetup."Phys.Inventory Journals"::Post);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Phys.Inventory Journal')
            end;
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Phys.Inventory Journals", '%1', UserSetup."Phys.Inventory Journals"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Phys.Inventory Journal');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Phys.Inventory Journals", '%1', UserSetup."Phys.Inventory Journals"::Post);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Phys.Inventory Journal');
        //ERROR('You do not have Permission to Delete Purchase Quote');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Phys.Inventory Journals", '%1', UserSetup."Phys.Inventory Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //  ERROR('You do not have Permission to Change Purchase Quote Details');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Phys.Inventory Journals", '%1', UserSetup."Phys.Inventory Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //    ERROR('You do not have Permission to Change Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Phys.Inventory Journals", '%1', UserSetup."Phys.Inventory Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);


        //   ERROR('You do not have Permission to add new Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Phys.Inventory Journals", '%1', UserSetup."Phys.Inventory Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Phys.Inventory Journals", '%1', UserSetup."Phys.Inventory Journals"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Phys.Inventory Journal');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Phys.Inventory Journals", '%1', UserSetup."Phys.Inventory Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    var
        UserSetup: Record 91;
}