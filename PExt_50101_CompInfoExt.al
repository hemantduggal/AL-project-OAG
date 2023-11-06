pageextension 50101 CompanyInformation1 extends "Company Information"
{
    layout
    {
        addafter(Address)
        {
            field("WHT Registration ID"; rec."WHT Registration ID")
            {
                ApplicationArea = all;
            }
        }
    }
}