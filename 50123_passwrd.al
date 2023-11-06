pageextension 50123 pass extends 9204
{
    layout
    {
        addafter(MyNotificationsLbl)
        {
            field(changepsswrd; changepsswrd)
            {
                Caption = ' Change Password';
                ApplicationArea = all;
                trigger OnAssistEdit()
                begin
                    EditNavPassword();
                end;
            }
        }
    }
    actions
    {
    }
    local procedure EditNavPassword()
    var
        PasswordDialogManagement: Codeunit "Password Dialog Management";
        Password: Text;
        user: Record user;
    begin
        CurrPage.SaveRecord;
        Commit();

        Password := PasswordDialogManagement.OpenPasswordDialog();

        if Password = '' then
            exit;
        SetUserPassword(UserSecurityId(), Password);
        CurrPage.Update(false);
        user.Get(UserSecurityId());
        user.validate("Change Password", false);
        user.Modify();
    end;

    var
        changepsswrd: Label '*********************';
}