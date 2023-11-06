tableextension 50017 PurcCrHeaderExt extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(50029; "Vendor Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Type';
            OptionCaption = ' ,Advance Vendors,Normal Vendors';
            OptionMembers = " ","Advance Vendors","Normal Vendors";
        }
        field(50013; "WHT Business Posting Group"; Code[20])
        {
            Caption = 'WHT Business Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Business Posting Group";
        }
    }
}