tableextension 50023 fixedAssetExt extends "Fixed Asset"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "WHT Product Posting Group"; Code[20])
        {
            Caption = 'WHT Product Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Product Posting Group";
        }
        field(50001; "Site/Plot No."; text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Street"; text[200]) { DataClassification = ToBeClassified; }
        field(50003; "Number of floors"; Text[200]) { DataClassification = ToBeClassified; }
        field(50004; "Number of Rooms"; Decimal) { DataClassification = ToBeClassified; }
        field(50005; "Title Deed No."; text[200]) { DataClassification = ToBeClassified; }
        field(50006; "Plot Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Freehold,Leasehold,"Freehold/ Uganda Land Commission";
        }
        field(50007; "Current Status"; text[200]) { DataClassification = ToBeClassified; }
        field(50008; "Purpose"; text[200]) { DataClassification = ToBeClassified; }
        field(50009; "Sectionsland"; Decimal) { DataClassification = ToBeClassified; }
        field(50010; "Physical Location"; text[200]) { DataClassification = ToBeClassified; }
        field(50011; "Date of Registration"; text[200]) { DataClassification = ToBeClassified; }
        field(50012; "Primary UOM"; Option)
        {
            OptionMembers = ,"-",Each;
            DataClassification = ToBeClassified;
        }
        field(50013; "Secondary UOM"; Option)
        {
            OptionMembers = ,"-",Hectare,Acre;
            DataClassification = ToBeClassified;
        }
        field(50014; "Lease (Yes or No)"; Option)
        {
            OptionMembers = ,Yes,No;
            DataClassification = ToBeClassified;
        }
        field(50015; " Sections"; text[200]) { DataClassification = ToBeClassified; }
        field(50016; "Date Placed In Service"; Date) { DataClassification = ToBeClassified; }
        field(50017; "Year of manufacture"; Integer) { DataClassification = ToBeClassified; }
        field(50018; "Model/type"; text[200]) { DataClassification = ToBeClassified; }
        field(50019; "Registration Number"; text[200]) { DataClassification = ToBeClassified; }
        field(50020; "Engine Type"; Option)
        {
            OptionMembers = ,Diesel,Petrol;
            DataClassification = ToBeClassified;
        }
        field(50021; "Engine Number"; text[200]) { DataClassification = ToBeClassified; }
        field(50022; "Sitting Capacity"; Decimal) { DataClassification = ToBeClassified; }
        field(50023; "User Name"; text[200]) { DataClassification = ToBeClassified; }
        field(50024; "User Title"; text[200]) { DataClassification = ToBeClassified; }
        field(50025; "Date of Purchase"; Date) { DataClassification = ToBeClassified; }
        field(50026; "Condition"; text[200]) { DataClassification = ToBeClassified; }
        field(50027; "Heritage"; Option)
        {
            OptionMembers = ,Yes,No;
            DataClassification = ToBeClassified;
        }
        field(50028; "Building Type"; text[200]) { DataClassification = ToBeClassified; }
        field(50029; "Cost/Control Center"; text[200]) { DataClassification = ToBeClassified; }
        field(50030; "Section"; text[200]) { DataClassification = ToBeClassified; }
        field(50031; "Tag Number"; text[200]) { DataClassification = ToBeClassified; }
        field(50032; "Serial number -PU"; text[200]) { DataClassification = ToBeClassified; }
        field(50033; "Serial number - Monitor"; text[200]) { DataClassification = ToBeClassified; }
        Field(50034; "ASSET_ID_MASTER"; Code[20]) { DataClassification = ToBeClassified; }
        Field(50035; "ASSET_NUMBER"; Code[20]) { DataClassification = ToBeClassified; }
        Field(50036; "BOOK_TYPE_CODE"; Option)
        {
            OptionMembers = ,"OAG FA BOOK";
            DataClassification = ToBeClassified;
        }
        Field(50037; "MAJOR"; Text[100]) { DataClassification = ToBeClassified; }
        Field(50038; "MINOR1"; Text[100]) { DataClassification = ToBeClassified; }
        Field(50039; "MINOR2"; Text[100]) { DataClassification = ToBeClassified; }
        Field(50040; "MINOR3"; Text[100]) { DataClassification = ToBeClassified; }
        Field(50041; "ASSET_TYPE"; Option)
        {
            OptionMembers = ,Capitalise,"Non Capitalise";
            DataClassification = ToBeClassified;
        }
        Field(50042; "UNITS"; Code[20]) { DataClassification = ToBeClassified; }
        Field(50043; "LOCATION_SEGMENT2"; Option)
        {
            OptionMembers = ,"FIIT AND SPECIAL AUDITS","CORPORATE TECH SUPPORT";
            DataClassification = ToBeClassified;
        }
        Field(50044; "DEPRICIATE_FLAG"; Option)
        {
            OptionMembers = ,Yes,No;
            DataClassification = ToBeClassified;
        }
        Field(50045; "LIFE_IN_MONTHS"; Code[20]) { DataClassification = ToBeClassified; }
        Field(50046; "PRORATE_CONVENTION"; Option)
        {
            OptionMembers = ,"GOU PRO CO";
            DataClassification = ToBeClassified;
        }
        Field(50047; "PRORATE_DATE"; Date) { DataClassification = ToBeClassified; }
        Field(50048; "MANUFACTURER_NAME"; Text[100]) { DataClassification = ToBeClassified; }
        Field(50049; "MODEL_NUMBER"; Code[20]) { DataClassification = ToBeClassified; }
        Field(50050; "OWNED_LEASED"; Option)
        {
            OptionMembers = ,Owned,"Not owned";
            DataClassification = ToBeClassified;
        }
        Field(50051; "NEW_USED"; Option)
        {
            OptionMembers = ,New,used;
            DataClassification = ToBeClassified;
        }
        Field(50052; "INVOICE_NUMBER"; Code[20]) { DataClassification = ToBeClassified; }
        Field(50053; "SUPPLIER_NO"; Code[20])
        {
            TableRelation = Vendor;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                vend: Record Vendor;
            begin
                if vend.get(Rec.SUPPLIER_NO) then
                    Rec.SUPPLIER_NAME := vend.Name;
            end;
        }
        Field(50054; "SUPPLIER_NAME"; Text[100]) { DataClassification = ToBeClassified; }
        Field(50055; "Status"; Option)
        {
            OptionMembers = Available,"Out of Store";
            DataClassification = ToBeClassified;
        }


    }
    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.AccessFixedAssetsMaster, '%1', UserSetup.AccessFixedAssetsMaster::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not create new Fixed Asset');
        //PRU_DD 1.10
    end;

    var
        myInt: Integer;
}