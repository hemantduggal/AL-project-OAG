pageextension 50008 ItemCardExt extends "Item Card"
{
    layout
    {
        modify("VAT Bus. Posting Gr. (Price)")
        {
            trigger OnAfterValidate()
            begin
                checkaccountuser();
            end;
        }
        modify("VAT Prod. Posting Group")
        {
            trigger OnAfterValidate()
            begin
                checkaccountuser();
            end;
        }
        addafter("Search Description")
        {
            field(RequistionItem; Rec.RequistionItem)
            {
                Caption = 'Requisition Item';
                ApplicationArea = all;
            }
        }
        modify("Vendor No.")
        {
            Caption = 'Approved Vendor';
        }
        addafter("Inventory Posting Group")
        {
            field("WHT Product Posting Group"; Rec."WHT Product Posting Group")
            {
                ApplicationArea = all;
                Visible = true;
            }
            field("WHT Exempt Product"; Rec."WHT Exempt Product")
            {
                ApplicationArea = all;
                Visible = true;
            }
        }
        addafter(Inventory)
        {
            field("Minimum Qty."; Rec."Minimum Qty.")
            {
                ApplicationArea = all;
            }
        }
        addafter(Warehouse)
        {
            group(Lines)
            {
                Caption = 'Lines';
                part(vendoritemrealtion; vendoritemrelation)
                {
                    SubPageLink = "item no." = field("No.");
                    ApplicationArea = All;
                }
            }
        }
    }
    procedure checkaccountuser()
    var
        user: Record "user setup";
    begin
        If user.get(UserId) then begin
            if user.storeuser = False then
                error('Only Account user have the access');
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Item Master');

        /*UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::Post);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Item Master');
        //ERROR('You do not have Permission to Delete Purchase Quote');
        //PRU_DD 1.10*/
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //  ERROR('You do not have Permission to Change Purchase Quote Details');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //    ERROR('You do not have Permission to Change Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);


        //   ERROR('You do not have Permission to add new Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Item Master');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        EDITN: Boolean;

}