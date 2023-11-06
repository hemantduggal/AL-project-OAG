page 50018 PostCodes_API
{
    ApplicationArea = Basic, Suite;
    Caption = 'Post Codes API';
    PageType = List;
    PopulateAllFields = true;
    SourceTable = "Post Code";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code"; rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the postal code that is associated with a city.';
                }
                field(City; rec.City)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the city linked to the postal code in the Code field.';
                }
                field("Country/Region Code"; rec."Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region of the address.';
                }
                field(County; rec.County)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a county name.';
                }
                field(TimeZone; rec."Time Zone")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Time Zone';
                    ToolTip = 'Specifies the time zone for the selected post code.';
                }
            }
        }

    }

}

