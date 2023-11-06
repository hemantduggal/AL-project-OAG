page 50026 "Blank. Purch. Subf. Short Clos"
{

    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = 39;
    SourceTableView = WHERE("Document Type" = FILTER("Blanket Order"));

    layout
    {
        area(content)
        {
            repeater(grp)
            {
                field(Type; rec.Type)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the line type.';

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                        DeltaUpdateTotals;
                    end;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';

                    trigger OnValidate()
                    begin
                        PurchLine.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                        DeltaUpdateTotals;
                    end;
                }
                field("Cross-Reference No."; rec."Cross-Reference No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the cross-referenced item number. If you enter a cross reference between yours and your vendor''s or customer''s item number, then this number will override the standard item number when you enter the cross-reference number on a sales or purchase document.';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        // CrossReferenceNoLookUp; //pru sh
                        InsertExtendedText(FALSE);
                        // OnCrossReferenceNoOnLookup(Rec); //pru sh
                    end;

                    trigger OnValidate()
                    begin
                        CrossReferenceNoOnAfterValidat;
                    end;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the variant of the item on the line.';
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the VAT specification of the involved item or resource to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals;
                    end;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a description of the blanket purchase order.';

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals;
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    ToolTip = 'Specifies the quantity of the purchase order line.';

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals;
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals;
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the name of the item or resource''s unit of measure, such as piece or hour.';
                    Visible = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    ToolTip = 'Specifies the cost of one unit of the selected item or resource.';

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals;
                    end;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the percentage of the item''s last purchase cost that includes indirect costs, such as freight that is associated with the purchase of the item.';
                    Visible = false;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the cost, in LCY, of one unit of the item or resource on the line.';
                    Visible = false;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the price, in LCY, of one unit of the item or resource. You can enter a price manually or have it entered according to the Price/Profit Calculation field on the related card.';
                    Visible = false;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    ToolTip = 'Specifies the discount percentage that is granted for the item on the line.';

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals;
                    end;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    ToolTip = 'Specifies the net amount, excluding any invoice discount amount, that must be paid for products on the line.';

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals;
                    end;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the discount amount that is granted for the item on the line.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals;
                    end;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies if the invoice line is included when the invoice discount is calculated.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals;
                    end;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    ToolTip = 'Specifies the quantity of items that remains to be received.';
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    ToolTip = 'Specifies how many units of the item on the line have been posted as received.';
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    ToolTip = 'Specifies how many units of the item on the line have been posted as invoiced.';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the date you expect the items to be available in your warehouse. If you leave the field blank, it will be calculated as follows: Planned Receipt Date + Safety Lead Time + Inbound Warehouse Handling Time = Expected Receipt Date.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = DimVisible1;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = DimVisible2;
                }
                /*  //pru sh
                                field(ShortcutDimCode[3];ShortcutDimCode[3])
                                {
                                    ApplicationArea = Dimensions;
                                    CaptionClass = '1,2,3';
                                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                                                  "Dimension Value Type"=CONST(Standard),
                                                                                  Blocked=CONST(false));
                                    Visible = DimVisible3;

                                    trigger OnValidate()
                                    begin
                                        ValidateShortcutDimCode(3,ShortcutDimCode[3]);
                                    end;
                                }

                                field(ShortcutDimCode[4];ShortcutDimCode[4])
                                {
                                    ApplicationArea = Dimensions;
                                    CaptionClass = '1,2,4';
                                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                                                  "Dimension Value Type"=CONST(Standard),
                                                                                  Blocked=CONST(false));
                                    Visible = DimVisible4;

                                    trigger OnValidate()
                                    begin
                                        ValidateShortcutDimCode(4,ShortcutDimCode[4]);
                                    end;
                                }
                                field(ShortcutDimCode[5];ShortcutDimCode[5])
                                {
                                    ApplicationArea = Dimensions;
                                    CaptionClass = '1,2,5';
                                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                                                  "Dimension Value Type"=CONST(Standard),
                                                                                  Blocked=CONST(false));
                                    Visible = DimVisible5;

                                    trigger OnValidate()
                                    begin
                                        ValidateShortcutDimCode(5,ShortcutDimCode[5]);
                                    end;
                                }
                                field(ShortcutDimCode[6];ShortcutDimCode[6])
                                {
                                    ApplicationArea = Dimensions;
                                    CaptionClass = '1,2,6';
                                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                                                  "Dimension Value Type"=CONST(Standard),
                                                                                  Blocked=CONST(false));
                                    Visible = DimVisible6;

                                    trigger OnValidate()
                                    begin
                                        ValidateShortcutDimCode(6,ShortcutDimCode[6]);
                                    end;
                                }
                                field(ShortcutDimCode[7];ShortcutDimCode[7])
                                {
                                    ApplicationArea = Dimensions;
                                    CaptionClass = '1,2,7';
                                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                                                  "Dimension Value Type"=CONST(Standard),
                                                                                  Blocked=CONST(false));
                                    Visible = DimVisible7;

                                    trigger OnValidate()
                                    begin
                                        ValidateShortcutDimCode(7,ShortcutDimCode[7]);
                                    end;
                                }
                                field(ShortcutDimCode[8];ShortcutDimCode[8])
                                {
                                    ApplicationArea = Dimensions;
                                    CaptionClass = '1,2,8';
                                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                                                  "Dimension Value Type"=CONST(Standard),
                                                                                  Blocked=CONST(false));
                                    Visible = DimVisible8;

                                    trigger OnValidate()
                                    begin
                                        ValidateShortcutDimCode(8,ShortcutDimCode[8]);
                                    end;
                                }
                                */ //pru sh
            }
            group(grp1)
            {
                group(grp2)
                {
                    field(AmountBeforeDiscount; TotalPurchaseLine."Line Amount")
                    {
                        ApplicationArea = Suite;
                        //AutoFormatExpression = "Currency Code"; //pru sh
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalLineAmountWithVATAndCurrencyCaption(Currency.Code, TotalPurchaseHeader."Prices Including VAT");
                        Caption = 'Subtotal Excl. VAT';
                        Editable = false;
                        ToolTip = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document.';

                        trigger OnValidate()
                        begin
                            DeltaUpdateTotals;
                        end;
                    }
                    field("Invoice Discount Amount"; InvoiceDiscountAmount)
                    {
                        ApplicationArea = Suite;
                        //AutoFormatExpression = "Currency Code"; //pru sh
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetInvoiceDiscAmountWithVATAndCurrencyCaption(rec.FIELDCAPTION("Inv. Discount Amount"), Currency.Code);
                        Caption = 'Invoice Discount Amount';
                        Editable = InvDiscAmountEditable;
                        ToolTip = 'Specifies a discount amount that is deducted from the value in the Total Incl. VAT field.';

                        trigger OnValidate()
                        begin
                            DocumentTotals.PurchaseDocTotalsNotUpToDate;
                            ValidateInvoiceDiscountAmount;
                        end;
                    }
                    field("Invoice Disc. Pct."; InvoiceDiscountPct)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Invoice Discount %';
                        DecimalPlaces = 0 : 2;
                        Editable = InvDiscAmountEditable;
                        ToolTip = 'Specifies a discount percentage that is granted if criteria that you have set up for the customer are met.';

                        trigger OnValidate()
                        begin
                            DocumentTotals.PurchaseDocTotalsNotUpToDate;
                            AmountWithDiscountAllowed := DocumentTotals.CalcTotalPurchAmountOnlyDiscountAllowed(Rec);
                            InvoiceDiscountAmount := ROUND(AmountWithDiscountAllowed * InvoiceDiscountPct / 100, Currency."Amount Rounding Precision");
                            ValidateInvoiceDiscountAmount;
                        end;
                    }
                }
                group(grp3)
                {
                    field("Total Amount Excl. VAT"; TotalPurchaseLine.Amount)
                    {
                        ApplicationArea = Suite;
                        //AutoFormatExpression = "Currency Code"; //pru sh
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(Currency.Code);
                        Caption = 'Total Amount Excl. VAT';
                        DrillDown = false;
                        Editable = false;
                        ToolTip = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.';
                    }
                    field("Total VAT Amount"; VATAmount)
                    {
                        ApplicationArea = Suite;
                        //AutoFormatExpression = "Currency Code"; //pru sh
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalVATCaption(Currency.Code);
                        Caption = 'Total VAT';
                        Editable = false;
                        ToolTip = 'Specifies the sum of VAT amounts on all lines in the document.';
                    }
                    field("Total Amount Incl. VAT"; TotalPurchaseLine."Amount Including VAT")
                    {
                        ApplicationArea = Suite;
                        //AutoFormatExpression = "Currency Code"; //pru sh
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(Currency.Code);
                        Caption = 'Total Amount Incl. VAT';
                        Editable = false;
                        ToolTip = 'Specifies the sum of the value in the Line Amount Incl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.';
                    }
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        GetTotalsPurchaseHeader;
        CalculateTotals;
        UpdateEditableOnRow;
    end;

    trigger OnAfterGetRecord()
    begin
        PurchLine.ShowShortcutDimCode(ShortcutDimCode);
        CLEAR(DocumentTotals);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        DocumentTotals.PurchaseDocTotalsNotUpToDate;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        DocumentTotals.PurchaseCheckAndClearTotals(Rec, xRec, TotalPurchaseLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
        EXIT(Rec.FIND(Which));
    end;

    trigger OnInit()
    begin
        PurchasesPayablesSetup.GET;
        Currency.InitRoundingPrecision;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        DocumentTotals.PurchaseCheckIfDocumentChanged(Rec, xRec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        PurchLine.InitType;
        CLEAR(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    begin
        SetDimensionsVisibility;
    end;



    var
        TotalPurchaseHeader: Record 38;
        TotalPurchaseLine: Record 39;
        PurchLine: Record 39;
        CurrentPurchLine: Record 39;
        Currency: Record 4;
        PurchasesPayablesSetup: Record 312;
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ItemAvailFormsMgt: Codeunit 353;
        PurchCalcDiscByType: Codeunit 66;
        DocumentTotals: Codeunit 57;
        ShortcutDimCode: array[8] of Code[20];
        VATAmount: Decimal;
        InvoiceDiscountAmount: Decimal;
        InvoiceDiscountPct: Decimal;
        AmountWithDiscountAllowed: Decimal;
        InvDiscAmountEditable: Boolean;
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;
        UpdateInvDiscountQst: Label 'One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?';


    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
        DocumentTotals.PurchaseDocTotalsNotUpToDate;
    end;

    local procedure ValidateInvoiceDiscountAmount()
    var
        PurchaseHeader: Record 38;
        ConfirmManagement: Codeunit "Confirm Management";
    begin
        PurchaseHeader.GET(rec."Document Type", rec."Document No.");
        IF PurchaseHeader.InvoicedLineExists THEN
            //  IF NOT ConfirmManagement.ConfirmProcess(UpdateInvDiscountQst, TRUE) THEN //pru sh
            EXIT;

        DocumentTotals.PurchaseDocTotalsNotUpToDate;
        PurchCalcDiscByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountAmount, PurchaseHeader);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
        DocumentTotals.PurchaseDocTotalsNotUpToDate;
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        // OnBeforeInsertExtendedText(Rec); //pru sh
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertPurchExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    local procedure GetTotalsPurchaseHeader()
    begin
        DocumentTotals.GetTotalPurchaseHeaderAndCurrency(Rec, TotalPurchaseHeader, Currency);
    end;

    local procedure CalculateTotals()
    begin
        DocumentTotals.PurchaseCheckIfDocumentChanged(Rec, xRec);
        DocumentTotals.CalculatePurchaseSubPageTotals(
          TotalPurchaseHeader, TotalPurchaseLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
        DocumentTotals.RefreshPurchaseLine(Rec);
    end;

    local procedure DeltaUpdateTotals()
    begin
        DocumentTotals.PurchaseDeltaUpdateTotals(Rec, xRec, TotalPurchaseLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
    end;

    local procedure UpdateEditableOnRow()
    begin
        InvDiscAmountEditable := CurrPage.EDITABLE AND NOT PurchasesPayablesSetup."Calc. Inv. Discount";
    end;

    local procedure ShowOrders()
    begin
        CurrentPurchLine := Rec;
        PurchLine.RESET;
        PurchLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Purchase Lines", PurchLine);

    end;

    local procedure ShowInvoices()
    begin
        CurrentPurchLine := Rec;
        PurchLine.RESET;
        PurchLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Invoice);
        PurchLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Purchase Lines", PurchLine);
    end;

    local procedure ShowReturnOrders()
    begin
        CurrentPurchLine := Rec;
        PurchLine.RESET;
        PurchLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::"Return Order");
        PurchLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Purchase Lines", PurchLine);
    end;

    local procedure ShowCreditMemos()
    begin
        CurrentPurchLine := Rec;
        PurchLine.RESET;
        PurchLine.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::"Credit Memo");
        PurchLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Purchase Lines", PurchLine);
    end;

    local procedure ShowPostedReceipts()
    var
        PurchRcptLine: Record 121;
    begin
        CurrentPurchLine := Rec;
        PurchRcptLine.RESET;
        PurchRcptLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        PurchRcptLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchRcptLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Posted Purchase Receipt Lines", PurchRcptLine);
    end;

    local procedure ShowPostedInvoices()
    var
        PurchInvLine: Record 123;
    begin
        CurrentPurchLine := Rec;
        PurchInvLine.RESET;
        PurchInvLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        PurchInvLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchInvLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Posted Purchase Invoice Lines", PurchInvLine);
    end;

    local procedure ShowPostedReturnReceipts()
    var
        ReturnShptLine: Record 6651;
    begin
        CurrentPurchLine := Rec;
        ReturnShptLine.RESET;
        ReturnShptLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        ReturnShptLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        ReturnShptLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Posted Return Shipment Lines", ReturnShptLine);
    end;

    local procedure ShowPostedCreditMemos()
    var
        PurchCrMemoLine: Record 125;
    begin
        CurrentPurchLine := Rec;
        PurchCrMemoLine.RESET;
        PurchCrMemoLine.SETCURRENTKEY("Blanket Order No.", "Blanket Order Line No.");
        PurchCrMemoLine.SETRANGE("Blanket Order No.", CurrentPurchLine."Document No.");
        PurchCrMemoLine.SETRANGE("Blanket Order Line No.", CurrentPurchLine."Line No.");
        PAGE.RUNMODAL(PAGE::"Posted Purchase Cr. Memo Lines", PurchCrMemoLine);
    end;

    procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
    end;

    procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(FALSE);
    end;

    procedure ShowDocumentLineTracking()
    var
        DocumentLineTracking: Page 6560;
    begin
        CLEAR(DocumentLineTracking);
        DocumentLineTracking.SetDoc(3, rec."Document No.", rec."Line No.", rec."Blanket Order No.", rec."Blanket Order Line No.", '', 0);
        DocumentLineTracking.RUNMODAL;
    end;

    procedure SetDimensionsVisibility()
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimVisible1 := FALSE;
        DimVisible2 := FALSE;
        DimVisible3 := FALSE;
        DimVisible4 := FALSE;
        DimVisible5 := FALSE;
        DimVisible6 := FALSE;
        DimVisible7 := FALSE;
        DimVisible8 := FALSE;

        DimMgt.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8);

        CLEAR(DimMgt);
    end;
}
/*
    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertExtendedText(var PurchaseLine: Record 39)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCrossReferenceNoOnLookup(var PurchaseLine: Record 39)
    begin
    end;
    */
