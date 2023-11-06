table 50019 "Catering Header"
{
    Caption = 'Catering header';
    DataClassification = ToBeClassified;
    LookupPageId = "Catering Card";

    fields
    {
        field(1; "No."; Code[30])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF Rec."No." <> xRec."No." THEN BEGIN
                    PurchSetup.GET;
                    NoSeriesMgt.TestManual(PurchSetup."Catering Requisition");
                    "No. Series" := '';
                END;

            end;
        }
        field(2; Description; text[300])
        {
            TableRelation = cateringdropdown;
            DataClassification = ToBeClassified;
        }
        field(3; "No. Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; meetingdate; date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; meetingTime; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Venue; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; expectedParticipent; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; user; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; createddate; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending for Approval,Approved,Rejected';
            OptionMembers = Open,"Pending for Approval",Approved,Rejected,"Short Close";//,"Short Close";
            DataClassification = ToBeClassified;
        }
        field(12; "1st Approved/Rejected User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";//"Application ID";//neha11-11-22
        }
        field(13; "1st Approved/Rejected Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "1st Reject Comment"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "2nd Approved/Rejected User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
            ;//User."User Name";//"Application ID";//neha11-11-22
        }
        field(16; "2nd Approved/Rejected Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "2nd Reject Comment"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Short Close"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Short Close Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record 91;
        DimMgt: Codeunit 408;

    trigger OnInsert()
    begin
        rec.createddate := CurrentDateTime;
        rec.user := UserId;
        PurchSetup.GET;
        PurchSetup.TESTFIELD(PurchSetup."Catering Requisition");
        IF "No." = '' THEN BEGIN
            NoSeriesMgt.InitSeries(PurchSetup."Catering Requisition", xRec."No. Series", 0D, "No.", "No. Series");
        END;
    end;

}