pageextension 50065 VendorCardEx extends "Vendor Card"
{

    layout
    {
        modify("Currency Code")
        {
            ShowMandatory = true;
        }
        modify("VAT Registration No.")
        {
            ShowMandatory = true;
            Caption = 'TIN';
            trigger OnAfterValidate()
            begin

            end;
        }
        addafter(Name)
        {
            field("Vendor Type"; Rec."Vendor Type")
            {
                ApplicationArea = all;
                ShowMandatory = true;
            }
            field(status; Rec.status)
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter("Vendor Posting Group")
        {
            field("WHT Business Posting Group"; rec."WHT Business Posting Group")
            {
                Applicationarea = All;
                trigger OnValidate()
                begin
                    checkaccountuser();
                end;
            }
            field("WHT Payable Amount (LCY)"; rec."WHT Payable Amount (LCY)")
            {
                Applicationarea = All;
                trigger OnValidate()
                begin
                    checkaccountuser();
                end;
            }
            field("WHT Registration ID"; rec."WHT Registration ID")
            {
                Applicationarea = All;
                trigger OnValidate()
                begin
                    checkaccountuser();
                end;
            }
            field("WHT Exempt Vendor"; rec."WHT Exempt Vendor")
            {
                Applicationarea = All;
                trigger OnValidate()
                begin
                    checkaccountuser();
                end;
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

    trigger OnClosePage()
    var
        iban: Record "Vendor Bank Account";
    begin
        rec.testfield("Vendor Type");
        if rec."Vendor Posting Group" = 'FOREIGN' then begin
            iban.SetRange("Vendor No.", rec."No.");
            if not iban.FindFirst() then begin
                Error('IBAN needs to be entered');
            end;
        end;
    end;

    trigger OnQueryClosePage(closeaction: action): Boolean
    var
        iban: Record "Vendor Bank Account";
    begin
        Rec.TestField("Currency Code");
        rec.testfield("Vendor Type");
        if rec."Vendor Posting Group" = 'FOREIGN' then begin
            iban.SetRange("Vendor No.", rec."No.");
            if not iban.FindFirst() then begin
                Error('IBAN needs to be entered');
            end;
        end;
        if Rec."VAT Registration No." = '' then
            Error('Tin No. must have a value in vendor card');
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Vendor Master');

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        rec.status := rec.status::Pending;
        rec.Modify();
        // Message('1');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        rec.status := rec.status::Pending;
        rec.Modify();
        // Message('2');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        rec.status := rec.status::Pending;
        rec.Modify();
        // Message('3');
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    var
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Vendor Master');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);

    end;



    var
        myInt: Integer;
        UserSetup: Record 91;
        MSMEEditable: Boolean;
        EDITN: Boolean;
        HasIncomingDocument: Boolean;

        Vendor: Record 23;

}