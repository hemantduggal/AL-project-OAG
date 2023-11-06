page 50052 "HCM Master"
{
    Caption = 'HCM Master';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = HCMMaster;
    layout
    {
        area(Content)
        {

            repeater(GroupName)
            {
                Caption = 'General';
                field(userID; Rec.userID)
                {
                    ApplicationArea = all;
                }
                field(HCM_Username; Rec.HCM_Username)
                {
                    ApplicationArea = all;
                }
                field(passwrd; Rec.passwrd)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}