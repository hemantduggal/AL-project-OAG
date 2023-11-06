pageextension 50082 FixedAssetCardExt extends 5600
{
    layout
    {
        moveafter("FA Subclass Code"; Description)
        modify("FA Class Code")
        {
            trigger OnAfterValidate()
            begin
                checkfaclasshandle();
            end;
        }
        modify("FA Subclass Code")
        {
            trigger OnAfterValidate()
            begin
                checkfaclasshandle();
            end;
        }
        addafter(Description)
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = all;
            }
        }
        addafter("Last Date Modified")
        {
            field("WHT Product Posting Group"; rec."WHT Product Posting Group")
            {
                ApplicationArea = all;
            }
        }
        addafter(Maintenance)
        {
            group(customs)
            {
                Caption = 'Fixed Asset Information';
                field("Site/Plot No."; rec."Site/Plot No.") { ApplicationArea = all; }
                field("Street"; rec."Street") { ApplicationArea = all; }
                field("Number of floors"; rec."Number of floors") { ApplicationArea = all; }
                field("Number of Rooms"; rec."Number of Rooms") { ApplicationArea = all; }
                field("Title Deed No."; rec."Title Deed No.") { ApplicationArea = all; }
                field("Plot Type"; rec."Plot Type") { ApplicationArea = all; }
                field("Current Status"; rec."Current Status") { ApplicationArea = all; }
                field("Purpose"; rec."Purpose") { ApplicationArea = all; }
                field("Sections Land"; rec."Sectionsland")
                {
                    Caption = 'Sections (Land)';
                    ApplicationArea = all;
                }
                field("Physical Location"; rec."Physical Location") { ApplicationArea = all; }
                field("Date of Registration"; rec."Date of Registration") { ApplicationArea = all; }
                field("Primary Unit of Measure (Each)"; rec."Primary UOM") { Caption = 'Primary Unit of Measure'; ApplicationArea = all; }
                field("Secondary Unit of Measure(Dropdown) (Hectare or Acre)"; rec."Secondary UOM") { Caption = 'Secondary Unit of Measure'; ApplicationArea = all; }
                field("Lease (Yes or No)"; rec."Lease (Yes or No)") { ApplicationArea = all; }
                field("Sections"; rec.Section) { ApplicationArea = all; }
                field("Date Placed In Service"; rec."Date Placed In Service") { ApplicationArea = all; }
                field("Year of manufacture"; rec."Year of manufacture") { ApplicationArea = all; }
                field("Model/type"; rec."Model/type") { ApplicationArea = all; }
                field("Registration Number"; rec."Registration Number") { ApplicationArea = all; }
                field("Engine Type"; rec."Engine Type") { ApplicationArea = all; }
                field("Engine Number"; rec."Engine Number") { ApplicationArea = all; }
                field("Sitting Capacity"; rec."Sitting Capacity") { ApplicationArea = all; }
                field("User Name"; rec."User Name") { ApplicationArea = all; }
                field("User Title"; rec."User Title") { ApplicationArea = all; }
                field("Date of Purchase"; rec."Date of Purchase") { ApplicationArea = all; }
                field("Condition"; rec."Condition") { ApplicationArea = all; }
                field("Heritage"; rec."Heritage") { ApplicationArea = all; }
                field("Building Type"; rec."Building Type") { ApplicationArea = all; }
                field("Cost/Control Center"; rec."Cost/Control Center") { ApplicationArea = all; }
                field("Section"; rec."Section") { ApplicationArea = all; }
                field("Tag Number"; rec."Tag Number") { ApplicationArea = all; }
                field("Serial number -PU"; rec."Serial number -PU") { ApplicationArea = all; }
                field("Serial number - Monitor"; rec."Serial number - Monitor") { ApplicationArea = all; }
                field("ASSET_ID_MASTER"; Rec."ASSET_ID_MASTER") { Caption = 'Asset-Id Master'; ApplicationArea = all; }
                field("ASSET_NUMBER"; Rec."ASSET_NUMBER") { Caption = 'Asset Number'; ApplicationArea = all; }
                field("BOOK_TYPE_CODE"; Rec."BOOK_TYPE_CODE") { Caption = 'Book type Code'; ApplicationArea = all; }
                field("MAJOR"; Rec."MAJOR")
                {
                    Caption = 'Major';
                    ApplicationArea = all;
                }
                field("MINOR1"; Rec."MINOR1") { Caption = 'Minor 1'; ApplicationArea = all; }
                field("MINOR2"; Rec."MINOR2") { Caption = 'Minor 2'; ApplicationArea = all; }
                field("MINOR3"; Rec."MINOR3") { Caption = 'Minor 3'; ApplicationArea = all; }
                field("ASSET_TYPE"; Rec."ASSET_TYPE") { Caption = 'Asset Type'; ApplicationArea = all; }
                field("UNITS"; Rec."UNITS") { Caption = 'Units'; ApplicationArea = all; }
                field("LOCATION_SEGMENT2"; Rec."LOCATION_SEGMENT2") { Caption = 'Location Segment 2'; ApplicationArea = all; }
                field("DEPRICIATE_FLAG"; Rec."DEPRICIATE_FLAG") { Caption = 'Depricate Flag'; ApplicationArea = all; }
                field("LIFE_IN_MONTHS"; Rec."LIFE_IN_MONTHS") { Caption = 'Life (In Months)'; ApplicationArea = all; }
                field("PRORATE_CONVENTION"; Rec."PRORATE_CONVENTION") { Caption = 'Prorate Convention'; ApplicationArea = all; }
                field("PRORATE_DATE"; Rec."PRORATE_DATE") { Caption = 'Prorate Date'; ApplicationArea = all; }
                field("MANUFACTURER_NAME"; Rec."MANUFACTURER_NAME") { Caption = 'Manufacturer Name'; ApplicationArea = all; }
                field("MODEL_NUMBER"; Rec."MODEL_NUMBER") { Caption = 'Model Number'; ApplicationArea = all; }
                field("OWNED_LEASED"; Rec."OWNED_LEASED") { Caption = 'Owned Leased'; ApplicationArea = all; }
                field("NEW_USED"; Rec."NEW_USED") { Caption = 'New Used'; ApplicationArea = all; }
                field("INVOICE_NUMBER"; Rec."INVOICE_NUMBER") { Caption = 'Invoice Number'; ApplicationArea = all; }
                field("SUPPLIER_NO"; Rec."SUPPLIER_NO") { Caption = 'Supplier No.'; ApplicationArea = all; }
                field("SUPPLIER_NAME"; Rec."SUPPLIER_NAME") { Caption = 'Supplier Name'; ApplicationArea = all; }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    procedure checkfaclasshandle()
    begin
        UserSetup.RESET;
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange(faclass, false);
        if UserSetup.FindFirst() then
            ERROR('You can not update this Fixed Asset inforamtion');
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.AccessFixedAssetsMaster, '%1', UserSetup.AccessFixedAssetsMaster::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Fixed Asset');

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.AccessFixedAssetsMaster, '%1', UserSetup.AccessFixedAssetsMaster::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //  ERROR('You do not have Permission to Change Purchase Quote Details');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.AccessFixedAssetsMaster, '%1', UserSetup.AccessFixedAssetsMaster::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //    ERROR('You do not have Permission to Change Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.AccessFixedAssetsMaster, '%1', UserSetup.AccessFixedAssetsMaster::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);


        //   ERROR('You do not have Permission to add new Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.AccessFixedAssetsMaster, '%1', UserSetup.AccessFixedAssetsMaster::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.AccessFixedAssetsMaster, '%1', UserSetup.AccessFixedAssetsMaster::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Fixed Asset');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.AccessFixedAssetsMaster, '%1', UserSetup.AccessFixedAssetsMaster::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;




    var
        UserSetup: Record 91;
}