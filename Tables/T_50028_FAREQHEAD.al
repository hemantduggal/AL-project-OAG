table 50028 "Requisition Header FA"
{
    DataClassification = ToBeClassified;
    Caption = 'Requisition Header FA';
    LookupPageId = RequisitionCardFA;

    fields
    {
        field(1; "Requisition Slip No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Requisition Slip No.';
            trigger OnValidate()
            begin
                IF "Requisition Slip No." <> xRec."Requisition Slip No." THEN BEGIN
                    PurchSetup.GET;
                    NoSeriesMgt.TestManual(PurchSetup."Material Requisition");
                    "No. Series" := '';
                END;

            end;
        }
        field(2; Description; Text[2047])
        {
            TableRelation = fastoredropdown;
            DataClassification = ToBeClassified;
        }
        field(3; "Requested User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin

            end;
        }
        field(4; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate() //neha11-11-22
            begin
                //SETFILTER("Request Date", '>=%1', Today);
                if "Request Date" < Today then
                    Error('Back Date is not Accepted. Request Date should be more than or equal to today.');
            end;
        }
        field(5; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending for Approval,Approved,Rejected,Issued';
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;//,"Short Close";
            DataClassification = ToBeClassified;
        }
        field(6; "Department"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            Caption = 'Department Code';//'Shortcut Dimension 1 Code';//15-11/22 hillary
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            /* trigger OnValidate()
             begin
                 // Rec.ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                 ValidateShortcutDimCode(1, "Department");
             end;*/
        }

        field(7; "1st Approved/Rejected User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";//"Application ID";//neha11-11-22
        }
        field(8; "1st Approved/Rejected Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "1st Reject Comment"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "2nd Approver"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(11; "2nd Approved/Rejected User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
            ;//User."User Name";//"Application ID";//neha11-11-22
        }
        field(12; "2nd Approved/Rejected Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "2nd Reject Comment"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Store Location"; Code[10])
        {
            TableRelation = Location.Code;
            DataClassification = ToBeClassified;

        }

        field(15; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(16; "Short Close"; Boolean)
        {
            Caption = 'Short Close';
            //Editable = false;
            DataClassification = ToBeClassified;
            trigger OnLookup()
            begin
            end;
        }
        field(17; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(19; "Reference No."; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(20; "Short Close Date"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(2));
        }
        field(22; Acknol_comment; text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Requisition Slip No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        usersetup: Record "User Setup";
        loc: Record Location;
    begin
        PurchSetup.GET;
        PurchSetup.TESTFIELD(PurchSetup."Material Requisition");
        IF "Requisition Slip No." = '' THEN BEGIN
            NoSeriesMgt.InitSeries(PurchSetup."Material Requisition", xRec."No. Series", 0D, "Requisition Slip No.", "No. Series");
        END;
        "Requested User ID" := USERID;

        usersetup.RESET;
        usersetup.SETRANGE("User ID", USERID);
        usersetup.SETFILTER(usersetup."Access Requisition Document", '%1', usersetup."Access Requisition Document"::View);
        IF usersetup.FINDFIRST THEN
            ERROR('You can not create new Requisition Document');

        loc.SetRange("Store location", true);
        if loc.FindFirst() then
            "Store Location" := loc.Code;

    end;

    local procedure GetNoSeriesCode(): Code[20]
    var
        myInt: Integer;
    begin
        PurchSetup.GET;
        PurchSetup.TESTFIELD("Material Requisition");
        EXIT(PurchSetup."Material Requisition");

    end;

    local procedure TestNoSeries(): Boolean
    var
        myInt: Integer;
    begin
        PurchSetup.TESTFIELD("Material Requisition");
    end;

    procedure AssistEdit(RequistionHeader: Record "Requisition Header"): Boolean
    var
        myInt: Integer;
        loc: Record Location;
    begin

        PurchSetup.GET;
        TestNoSeries;
        IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, RequistionHeader."No. Series", "No. Series") THEN BEGIN
            TestNoSeries;
            NoSeriesMgt.SetSeries("Requisition Slip No.");
            EXIT(TRUE);
        END;

    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record 91;
        DimMgt: Codeunit 408;



}