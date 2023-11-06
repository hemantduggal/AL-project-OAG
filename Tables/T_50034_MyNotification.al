table 50034 Notifications
{
    DataClassification = ToBeClassified;
    // Caption = 'Reallocation Journal quater';
    fields
    {
        field(1; entryno; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            // AutoIncrement = true;
        }
        field(3; recordID; RecordId)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Notification details"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Notificationdatetime; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnInsert()
    begin
        Notificationdatetime := CurrentDateTime;
    end;
}