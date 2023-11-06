table 50002 "Archieve Req Header"
{
    DataClassification = ToBeClassified;
    Caption = 'Archieve Req Header';
    LookupPageId = "Archieve Req Card";

    fields
    {
        field(1; "Archive Requisition Slip No."; Code[20])
        {

            DataClassification = ToBeClassified;
            Caption = 'Requisition Slip No.';

        }
        field(2; Description; Text[2047])
        {
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
                SETFILTER("Request Date", '>=%1', Today);
                if "Request Date" < Today then
                    Message('Back Date is not Accepted. Request Date should be more than or equal to today.');
            end;
        }
        field(5; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending for Approval,Approved,Rejected';
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;//,"Short Close";
            DataClassification = ToBeClassified;
        }
        field(6; "Department"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            Caption = 'Department';//'Shortcut Dimension 1 Code';
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
            TableRelation = User."Application ID";//neha11-11-22
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
        field(11; "2nd Approved/Rejected User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."Application ID";//neha11-11-22
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
        field(18; "Requisition Slip No."; Code[20])
        {

            DataClassification = ToBeClassified;
            Caption = 'Requisition Slip No.';
        }
        field(19; "Reference No."; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(22; Acknol_comment; text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Archive Requisition Slip No.")
        {
            Clustered = true;
        }
    }


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