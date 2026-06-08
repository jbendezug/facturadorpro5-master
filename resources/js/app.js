require('./bootstrap');

import Vue from 'vue'
import store from './store'
import ElementUI from 'element-ui'
import { keyboard } from './mixins/keyboard'
import { validation } from './mixins/validation'
import { notifySuccess, notifyError, toastSuccess } from './helpers/notify'

import lang from 'element-ui/lib/locale/lang/es'
import locale from 'element-ui/lib/locale'

locale.use(lang)

ElementUI.Select.computed.readonly = function () {
    const isIE = !this.$isServer && !Number.isNaN(Number(document.documentMode));
    return !(this.filterable || this.multiple || !isIE) && !this.visible;
};

export default ElementUI;

Vue.use(ElementUI, { size: 'small' })
Vue.prototype.$eventHub = new Vue()
Vue.mixin(keyboard)
Vue.mixin(validation)
Vue.prototype.$notifySuccess = notifySuccess
Vue.prototype.$notifyError = notifyError
Vue.prototype.$toastSuccess = toastSuccess

Vue.component('tenant-item-aditional-info-selector', () => import('./views/tenant/components/partials/item_extra_info.vue'));
Vue.component('tenant-item-aditional-info-modal', () => import('./views/tenant/components/partials/modal_item_info_attributes.vue'));


Vue.component('tenant-dashboard-index', () => import('../../modules/Dashboard/Resources/assets/js/views/index.vue'));
Vue.component('tenant-dashboard-sales-by-product', () => import('../../modules/Dashboard/Resources/assets/js/views/items/SalesByProduct.vue'));

Vue.component('x-graph', () => import('./components/graph/src/Graph.vue'));
Vue.component('x-graph-line', () => import('./components/graph/src/GraphLine.vue'));

// configuracion pse
Vue.component('tenant-signature-pse-index', () => import('./views/tenant/companies/signature_pse/index.vue'))

Vue.component('tenant-companies-form', () => import('./views/tenant/companies/form.vue'));
Vue.component('tenant-companies-logo', () => import('./views/tenant/companies/logo.vue'));
Vue.component('tenant-certificates-index', () => import('./views/tenant/certificates/index.vue'));
Vue.component('tenant-certificates-form', () => import('./views/tenant/certificates/form.vue'));
Vue.component('tenant-configurations-form', () => import('./views/tenant/configurations/form.vue'));
Vue.component('tenant-configurations-form-purchases', () => import('./views/tenant/configurations/partials/purchases.vue'));
Vue.component('tenant-configurations-visual', () => import('./views/tenant/configurations/visual.vue'));
Vue.component('tenant-configurations-pdf', () => import('./views/tenant/configurations/pdf_templates.vue'));
Vue.component('tenant-configurations-ticket-pdf', () => import('./views/tenant/configurations/pdf_ticket_templates.vue'));
Vue.component('tenant-configurations-sale-notes', () => import('./views/tenant/configurations/sale_notes.vue'));
Vue.component('tenant-configurations-pdf-guide', () => import('./views/tenant/configurations/pdf_guide_templates.vue'));
Vue.component('tenant-configurations-preprinted-pdf', () => import('./views/tenant/configurations/pdf_preprinted_templates.vue'));
Vue.component('tenant-dialog-header-menu', () => import('./views/tenant/configurations/partials/dialog_header_menu.vue'));
// Vue.component('tenant-establishments-form', () => import('./views/tenant/establishments/form.vue'));
// Vue.component('tenant-series-form', () => import('./views/tenant/series/form.vue'));
Vue.component('tenant-bank_accounts-index', () => import('./views/tenant/bank_accounts/index.vue'));
Vue.component('tenant-items-index', () => import('./views/tenant/items/index.vue'));
Vue.component('tenant-persons-index', () => import('./views/tenant/persons/index.vue'));
// Vue.component('tenant-customers-index', () => import('./views/tenant/customers/index.vue'));
 Vue.component('tenant-person-form', () => import('./views/tenant/persons/form.vue'));

// Vue.component('tenant-suppliers-index', () => import('./views/tenant/suppliers/index.vue'));
Vue.component('tenant-users-form', () => import('./views/tenant/users/form.vue'));
Vue.component('tenant-documents-index', () => import('./views/tenant/documents/index.vue'));
Vue.component('tenant-documents-invoice', () => import('./views/tenant/documents/invoice.vue'));
Vue.component('tenant-documents-invoicetensu', () => import('./views/tenant/documents/invoicetensu.vue'));
Vue.component('tenant-documents-note', () => import('./views/tenant/documents/note.vue'));

// purchase-settlements
Vue.component('tenant-purchase-settlements-index', () => import('./views/tenant/purchase-settlements/index.vue'));

Vue.component('tenant-documents-items-list', () => import('./views/tenant/documents/partials/item.vue'));
Vue.component('tenant-summaries-index', () => import('./views/tenant/summaries/index.vue'));
Vue.component('tenant-voided-index', () => import('./views/tenant/voided/index.vue'));
Vue.component('tenant-search-index', () => import('./views/tenant/search/index.vue'));
Vue.component('tenant-options-form', () => import('./views/tenant/options/form.vue'));
Vue.component('tenant-unit_types-index', () => import('./views/tenant/unit_types/index.vue'));
Vue.component('tenant-detraction_types-index', () => import('./views/tenant/detraction_types/index.vue'));
Vue.component('tenant-users-index', () => import('./views/tenant/users/index.vue'));
Vue.component('tenant-establishments-index', () => import('./views/tenant/establishments/index.vue'));
Vue.component('tenant-charge_discounts-index', () => import('./views/tenant/charge_discounts/index.vue'));
Vue.component('tenant-banks-index', () => import('./views/tenant/banks/index.vue'));
Vue.component('tenant-exchange_rates-index', () => import('./views/tenant/exchange_rates/index.vue'));
Vue.component('tenant-currency-types-index', () => import('./views/tenant/currency_types/index.vue'));
Vue.component('tenant-retentions-index', () => import('./views/tenant/retentions/index.vue'));
Vue.component('tenant-retentions-form', () => import('./views/tenant/retentions/form.vue'));
Vue.component('tenant-perceptions-index', () => import('./views/tenant/perceptions/index.vue'));
Vue.component('tenant-perceptions-form', () => import('./views/tenant/perceptions/form.vue'));
Vue.component('tenant-dispatches-index', () => import('./views/tenant/dispatches/index.vue'));
Vue.component('tenant-dispatches-form', () => import('./views/tenant/dispatches/form.vue'));
Vue.component('tenant-dispatches-create', () => import('./views/tenant/dispatches/create.vue'));
Vue.component('tenant-guides-modal', () => import('./views/tenant/components/guides.vue'));
Vue.component('tenant-purchases-index', () => import('./views/tenant/purchases/index.vue'));
Vue.component('tenant-purchases-form', () => import('./views/tenant/purchases/form.vue'));
Vue.component('tenant-purchases-edit', () => import('./views/tenant/purchases/form_edit.vue'));
Vue.component('tenant-transfer-reason-types-index', () => import('./views/tenant/transfer_reason_types/index.vue'));

Vue.component('tenant-purchases-items', () => import('./views/tenant/dispatches/items.vue'));
Vue.component('tenant-attribute_types-index', () => import('./views/tenant/attribute_types/index.vue'));
Vue.component('tenant-calendar', () => import('./views/tenant/components/calendar.vue'));
Vue.component('tenant-warehouses', () => import('./views/tenant/components/warehouses.vue'));
Vue.component('tenant-calendar-quotation', () => import('./views/tenant/components/calendarquotations.vue'));

//Vue.component('tenant-calendar', () => import('./views/tenant/components/calendar.vue'));
Vue.component('tenant-product', () => import('./views/tenant/components/products.vue'));


Vue.component('tenant-tasks-lists', () => import('./views/tenant/tasks/lists.vue'));
Vue.component('tenant-tasks-form', () => import('./views/tenant/tasks/form.vue'));
Vue.component('tenant-reports-consistency-documents-lists', () => import('./views/tenant/reports/consistency-documents/lists.vue'));
Vue.component('tenant-contingencies-index', () => import('./views/tenant/contingencies/index.vue'));

Vue.component('tenant-quotations-index', () => import('./views/tenant/quotations/index.vue'));
Vue.component('tenant-quotations-form', () => import('./views/tenant/quotations/form.vue'));
Vue.component('tenant-quotations-edit', () => import('./views/tenant/quotations/form_edit.vue'));
Vue.component('tenant-quotations-item-form', () => import('./views/tenant/quotations/partials/item.vue'));

Vue.component('tenant-sale-notes-index', () => import('./views/tenant/sale_notes/index.vue'));
Vue.component('tenant-sale-notes-form', () => import('./views/tenant/sale_notes/form.vue'));
Vue.component('tenant-pos-index', () => import('./views/tenant/pos/index.vue'));
Vue.component('cash-index', () => import('./views/tenant/cash/index.vue'));
Vue.component('tenant-card-brands-index', () => import('./views/tenant/card_brands/index.vue'));
Vue.component('tenant-pos-fast', () => import('./views/tenant/pos/fast.vue'));
Vue.component('tenant-pos-garage', () => import('./views/tenant/pos/garage.vue'));

Vue.component('tenant-payment-method-index', () => import('./views/tenant/payment_method/index.vue'));
Vue.component('tenant-payment-method-index', () => import('./views/tenant/payment_method/index.vue'));



// Modules
Vue.component('inventory-index', () => import('../../modules/Inventory/Resources/assets/js/inventory/index.vue'));
Vue.component('inventory-transfers-index', () => import('../../modules/Inventory/Resources/assets/js/transfers/index.vue'));
Vue.component('warehouses-index', () => import('../../modules/Inventory/Resources/assets/js/warehouses/index.vue'));
Vue.component('tenant-report-kardex-index', () => import('../../modules/Inventory/Resources/assets/js/kardex/index.vue'));
Vue.component('tenant-inventories-form', () => import('../../modules/Inventory/Resources/assets/js/config/form.vue'));
Vue.component('tenant-expenses-index', () => import('../../modules/Expense/Resources/assets/js/views/expenses/index.vue'));
Vue.component('tenant-expenses-form', () => import('../../modules/Expense/Resources/assets/js/views/expenses/form.vue'));
Vue.component('tenant-account-export', () => import('../../modules/Account/Resources/assets/js/views/account/export.vue'));
Vue.component('tenant-account-summary-report', () => import('../../modules/Account/Resources/assets/js/views/summary_report/index.vue'));
Vue.component('tenant-account-format', () => import('../../modules/Account/Resources/assets/js/views/account/format.vue'));
Vue.component('tenant-company-accounts', () => import('../../modules/Account/Resources/assets/js/views/company_accounts/form.vue'));
Vue.component('tenant-ledger-accounts', () => import('../../modules/Account/Resources/assets/js/views/ledger_accounts/form.vue'));


//
Vue.component('tenant-inventory-report', () => import('../../modules/Inventory/Resources/assets/js/inventory/reports/index.vue'));
//


Vue.component('tenant-inventory-color-index', () => import('../../modules/Inventory/Resources/assets/js/extra_info/color/index.vue'));
Vue.component('tenant-inventory-item-units-per-package-index', () => import('../../modules/Inventory/Resources/assets/js/extra_info/item_units_per_package/index.vue'));
Vue.component('tenant-inventory-item-units-business', () => import('../../modules/Inventory/Resources/assets/js/extra_info/item_units_business/index.vue'));
Vue.component('tenant-inventory-item-package-measurements', () => import('../../modules/Inventory/Resources/assets/js/extra_info/item_package_measurements/index.vue'));
Vue.component('tenant-inventory-mold-cavities', () => import('../../modules/Inventory/Resources/assets/js/extra_info/item_mold_cavities/index.vue'));
Vue.component('tenant-inventory-mold-property', () => import('../../modules/Inventory/Resources/assets/js/extra_info/item_mold_property/index.vue'));

Vue.component('tenant-inventory-size-property', () => import('../../modules/Inventory/Resources/assets/js/extra_info/item_size/index.vue'));
Vue.component('tenant-inventory-item-status', () => import('../../modules/Inventory/Resources/assets/js/extra_info/item_status/index.vue'));
Vue.component('tenant-inventory-item-product-family', () => import('../../modules/Inventory/Resources/assets/js/extra_info/item_product_family/index.vue'));
Vue.component('tenant-inventory-extra-info-list', () => import('../../modules/Inventory/Resources/assets/js/extra_info/index.vue'));

Vue.component('tenant-inventory-devolutions-index', () => import('../../modules/Inventory/Resources/assets/js/devolutions/index.vue'));
Vue.component('tenant-inventory-devolutions-form', () => import('../../modules/Inventory/Resources/assets/js/devolutions/form.vue'));

Vue.component('tenant-documents-not-sent', () => import('../../modules/Document/Resources/assets/js/views/documents/not_sent.vue'));
Vue.component('tenant-report-purchases-index', () => import('../../modules/Report/Resources/assets/js/views/purchases/index.vue'));
Vue.component('tenant-report-documents-index', () => import('../../modules/Report/Resources/assets/js/views/documents/index.vue'));
Vue.component('tenant-report-customers-index', () => import('../../modules/Report/Resources/assets/js/views/customers/index.vue'));
Vue.component('tenant-report-items-index', () => import('../../modules/Report/Resources/assets/js/views/items/index.vue'));
Vue.component('tenant-report-items-extra-index', () => import('../../modules/Report/Resources/assets/js/views/items/index_extra.vue'));

Vue.component('tenant-report-download-tray-index', () => import('../../modules/Report/Resources/assets/js/views/download_tray/index.vue'));

/** Reporte de guias */
Vue.component('tenant-report-guide-index', () => import('../../modules/Report/Resources/assets/js/views/guide/index.vue'));
Vue.component('tenant-report-sale_notes-index', () => import('../../modules/Report/Resources/assets/js/views/sale_notes/index.vue'));
Vue.component('tenant-report-quotations-index', () => import('../../modules/Report/Resources/assets/js/views/quotations/index.vue'));
Vue.component('tenant-report-cash-index', () => import('../../modules/Report/Resources/assets/js/views/cash/index.vue'));
Vue.component('tenant-index-configuration', () => import('../../modules/BusinessTurn/Resources/assets/js/views/configurations/index.vue'));
Vue.component('tenant-report-document_hotels-index', () => import('../../modules/Report/Resources/assets/js/views/document_hotels/index.vue'));
Vue.component('tenant-report_hotels-index', () => import('../../modules/Report/Resources/assets/js/views/report_hotels/index.vue'));
Vue.component('tenant-report-commercial_analysis-index', () => import('../../modules/Report/Resources/assets/js/views/commercial_analysis/index.vue'));
Vue.component('tenant-offline-configurations-index', () => import('../../modules/Offline/Resources/assets/js/views/offline_configurations/index.vue'));
Vue.component('tenant-series-configurations-index', () => import('../../modules/Document/Resources/assets/js/views/series_configurations/index.vue'));
Vue.component('tenant-validate-documents-index', () => import('../../modules/Document/Resources/assets/js/views/validate_documents/index.vue'));
Vue.component('tenant-report-document-detractions-index', () => import('../../modules/Report/Resources/assets/js/views/document-detractions/index.vue'));
Vue.component('tenant-report-commissions-index', () => import('../../modules/Report/Resources/assets/js/views/commissions/index.vue'));
Vue.component('tenant-report-order-notes-consolidated-index', () => import('../../modules/Report/Resources/assets/js/views/order_notes_consolidated/index.vue'));
Vue.component('tenant-report-general-items-index', () => import('../../modules/Report/Resources/assets/js/views/general_items/index.vue'));
Vue.component('tenant-report-order-notes-general-index', () => import('../../modules/Report/Resources/assets/js/views/order_notes_general/index.vue'));
Vue.component('tenant-report-sales-consolidated-index', () => import('../../modules/Report/Resources/assets/js/views/sales_consolidated/index.vue'));
Vue.component('tenant-report-user-commissions-index', () => import('../../modules/Report/Resources/assets/js/views/user_commissions/index.vue'));
Vue.component('tenant-report-fixed-asset-purchases-index', () => import('../../modules/Report/Resources/assets/js/views/fixed-asset-purchases/index.vue'));
Vue.component('tenant-report-massive-downloads-index', () => import('../../modules/Report/Resources/assets/js/views/massive-downloads/index.vue'));
Vue.component('tenant-documents-regularize-shipping', () => import('../../modules/Document/Resources/assets/js/views/documents/regularize_shipping.vue'));
Vue.component('tenant-report-commissions-detail-index', () => import('../../modules/Report/Resources/assets/js/views/commissions_detail/index.vue'));

Vue.component('tenant-report-tips-index', () => import('../../modules/Report/Resources/assets/js/views/tips/index.vue'));

Vue.component('tenant-categories-index', () => import('../../modules/Item/Resources/assets/js/views/categories/index.vue'));
Vue.component('tenant-brands-index', () => import('../../modules/Item/Resources/assets/js/views/brands/index.vue'));
Vue.component('tenant-zone-index', () => import('../../modules/Item/Resources/assets/js/views/zone/index.vue'));
Vue.component('tenant-incentives-index', () => import('../../modules/Item/Resources/assets/js/views/incentives/index.vue'));
Vue.component('tenant-item-lots-index', () => import('../../modules/Item/Resources/assets/js/views/item-lots/index.vue'));

Vue.component('tenant-ecommerce-configuration-info', () => import('../../modules/Ecommerce/Resources/assets/js/views/configuration/index.vue'));
Vue.component('tenant-ecommerce-configuration-culqi', () => import('../../modules/Ecommerce/Resources/assets/js/views/configuration_culqi/index.vue'));
Vue.component('tenant-ecommerce-configuration-paypal', () => import('../../modules/Ecommerce/Resources/assets/js/views/configuration_paypal/index.vue'));
Vue.component('tenant-ecommerce-configuration-logo', () => import('../../modules/Ecommerce/Resources/assets/js/views/configuration_logo/index.vue'));
Vue.component('tenant-ecommerce-configuration-social', () => import('../../modules/Ecommerce/Resources/assets/js/views/configuration_social/index.vue'));
Vue.component('tenant-ecommerce-configuration-tag', () => import('../../modules/Ecommerce/Resources/assets/js/views/configuration_tags/index.vue'));
Vue.component('tenant-ecommerce-item-sets-index', () => import('../../modules/Ecommerce/Resources/assets/js/views/item_sets/index.vue'));

Vue.component('tenant-purchase-quotations-index', () => import('../../modules/Purchase/Resources/assets/js/views/purchase-quotations/index.vue'));
Vue.component('tenant-purchase-quotations-form', () => import('../../modules/Purchase/Resources/assets/js/views/purchase-quotations/form.vue'));

Vue.component('tenant-purchase-orders-index', () => import('../../modules/Purchase/Resources/assets/js/views/purchase-orders/index.vue'));
Vue.component('tenant-purchase-orders-form', () => import('../../modules/Purchase/Resources/assets/js/views/purchase-orders/form.vue'));
Vue.component('tenant-purchase-orders-generate', () => import('../../modules/Purchase/Resources/assets/js/views/purchase-orders/generate.vue'));

Vue.component('moves-index', () => import('../../modules/Inventory/Resources/assets/js/moves/index.vue'));
Vue.component('inventory-form-masive', () => import('../../modules/Inventory/Resources/assets/js/transfers/form_masive.vue'));

Vue.component('tenant-report-kardex-master', () => import('../../modules/Inventory/Resources/assets/js/kardex_master/index.vue'));
Vue.component('tenant-report-kardex-lots', () => import('../../modules/Inventory/Resources/assets/js/kardex/lots.vue'));
Vue.component('tenant-report-kardex-series', () => import('../../modules/Inventory/Resources/assets/js/kardex/series.vue'));

Vue.component('tenant-order-notes-index', () => import('../../modules/Order/Resources/assets/js/views/order_notes/index.vue'));
Vue.component('tenant-order-notes-form', () => import('../../modules/Order/Resources/assets/js/views/order_notes/form.vue'));
Vue.component('tenant-order-notes-edit', () => import('../../modules/Order/Resources/assets/js/views/order_notes/form_edit.vue'));
Vue.component('tenant-report-valued-kardex', () => import('../../modules/Inventory/Resources/assets/js/valued_kardex/index.vue'));
Vue.component('tenant-mitiendape-config', () => import('../../modules/Order/Resources/assets/js/views/mi_tienda_pe/form.vue'));


//Finance
Vue.component('tenant-finance-global-payments-index', () => import('../../modules/Finance/Resources/assets/js/views/global_payments/index.vue'));
Vue.component('tenant-finance-balance-index', () => import('../../modules/Finance/Resources/assets/js/views/balance/index.vue'));
Vue.component('tenant-finance-modal-transfer-between-accounts', () => import('../../modules/Finance/Resources/assets/js/views/transfer_between_accounts/options.vue'));

Vue.component('tenant-finance-payment-method-types-index', () => import('../../modules/Finance/Resources/assets/js/views/payment_method_types/index.vue'));
Vue.component('tenant-finance-unpaid-index', () => import('@viewsModuleFinance/unpaid/index.vue'));
Vue.component('tenant-finance-to-pay-index', () => import('@viewsModuleFinance/to_pay/index.vue'));
Vue.component('tenant-finance-income-index', () => import('@viewsModuleFinance/income/index.vue'));
Vue.component('tenant-finance-income-form', () => import('@viewsModuleFinance/income/form.vue'));
Vue.component('tenant-income-types-index', () => import('@viewsModuleFinance/income_types/index.vue'));
Vue.component('tenant-income-reasons-index', () => import('@viewsModuleFinance/income_reasons/index.vue'));
Vue.component('tenant-finance-movements-index', () => import('@viewsModuleFinance/movements/index.vue'));


//Sale
Vue.component('tenant-sale-opportunities-index', () => import('@viewsModuleSale/sale_opportunities/index.vue'));
Vue.component('tenant-sale-opportunities-form', () => import('@viewsModuleSale/sale_opportunities/form.vue'));
Vue.component('tenant-payment-method-types-index', () => import('@viewsModuleSale/payment_method_types/index.vue'));
Vue.component('tenant-contracts-index', () => import('@viewsModuleSale/contracts/index.vue'));
Vue.component('tenant-contracts-form', () => import('@viewsModuleSale/contracts/form.vue'));
Vue.component('tenant-production-orders-index', () => import('@viewsModuleSale/production_orders/index.vue'));

//Item
Vue.component('tenant-web-platforms-index', () => import('@viewsModuleItem/web-platforms/index.vue'));

//technical Services
Vue.component('tenant-technical-services-index', () => import('@viewsModuleSale/technical-services/index.vue'));
Vue.component('tenant-user-commissions-index', () => import('@viewsModuleSale/user-commissions/index.vue'));

//Purchase

Vue.component('tenant-fixed-asset-items-index', () => import('@viewsModulePurchase/fixed_asset_items/index.vue'));
Vue.component('tenant-fixed-asset-purchases-index', () => import('@viewsModulePurchase/fixed_asset_purchases/index.vue'));
Vue.component('tenant-fixed-asset-purchases-form', () => import('@viewsModulePurchase/fixed_asset_purchases/form.vue'));

//Expense

Vue.component('tenant-expense-types-index', () => import('@viewsModuleExpense/expense_types/index.vue'));
Vue.component('tenant-expense-reasons-index', () => import('@viewsModuleExpense/expense_reasons/index.vue'));
Vue.component('tenant-expense-method-types-index', () => import('@viewsModuleExpense/expense_method_types/index.vue'));

//Order
Vue.component('tenant-drivers-index', () => import('@viewsModuleOrder/drivers/index.vue'));
Vue.component('tenant-dispatchers-index', () => import('@viewsModuleOrder/dispatchers/index.vue'));
Vue.component('tenant-order-forms-index', () => import('@viewsModuleOrder/order_forms/index.vue'));
Vue.component('tenant-order-forms-form', () => import('@viewsModuleOrder/order_forms/form.vue'));


// System
Vue.component('system-clients-index', () => import('./views/system/clients/index.vue'));
Vue.component('system-clients-form', () => import('./views/system/clients/form.vue'));
Vue.component('system-users-form', () => import('./views/system/users/form.vue'));

Vue.component('system-certificate-index', () => import('./views/system/certificate/index.vue'));
Vue.component('system-companies-form', () => import('./views/system/companies/form.vue'));

Vue.component('system-accounting-index', () => import('@viewsModuleAccount/system/accounting/index.vue'));

// Hoteles :: Tarifas
Vue.component('tenant-hotel-rates', () => import('@viewsModuleHotel/rates/List.vue'));
// Hoteles :: Categorías
Vue.component('tenant-hotel-categories', () => import('@viewsModuleHotel/categories/List.vue'));
// Hoteles :: Pisos
Vue.component('tenant-hotel-floors', () => import('@viewsModuleHotel/floors/List.vue'));
// Hoteles :: Habitaciones
Vue.component('tenant-hotel-rooms', () => import('@viewsModuleHotel/rooms/List.vue'));
// Hoteles :: Recepción
Vue.component('tenant-hotel-reception', () => import('@viewsModuleHotel/rooms/Reception.vue'));
// Hoteles :: Rentar habitación
Vue.component('tenant-hotel-rent', () => import('@viewsModuleHotel/rooms/Rent.vue'));
// Hoteles :: Agregar producto a la habitación rentada
Vue.component('tenant-hotel-rent-add-product', () => import('@viewsModuleHotel/rooms/AddProductToRoom.vue'));
// Hoteles :: Checkout
Vue.component('tenant-hotel-rent-checkout', () => import('@viewsModuleHotel/rooms/Checkout.vue'));

// Trámite documentario
Vue.component('tenant-documentary-offices', () => import('@viewsModuleDocumentary/offices/Offices.vue'));
Vue.component('tenant-documentary-status', () => import('@viewsModuleDocumentary/status/Status.vue'));
Vue.component('tenant-documentary-processes', () => import('@viewsModuleDocumentary/processes/Processes.vue'));
Vue.component('tenant-documentary-documents', () => import('@viewsModuleDocumentary/documents/Documents.vue'));
Vue.component('tenant-documentary-actions', () => import('@viewsModuleDocumentary/actions/Actions.vue'));
Vue.component('tenant-documentary-files', () => import('@viewsModuleDocumentary/files/Files.vue'));
Vue.component('tenant-documentary-requirements', () => import('@viewsModuleDocumentary/requirements/Requirements.vue'));
Vue.component('tenant-documentary-statistic', () => import('@viewsModuleDocumentary/statistic/Index.vue'));

// Trámite documentario Simlpificado
Vue.component('tenant-documentary-files-simplify', () => import('@viewsModuleDocumentary/files_simplify/Files.vue'));
Vue.component('tenant-documentary-files-simplify-form', () => import('@viewsModuleDocumentary/files_simplify/FilesNew.vue'));

Vue.component('system-plans-index', () => import('./views/system/plans/index.vue'));
Vue.component('system-plans-form', () => import('./views/system/plans/form.vue'));

Vue.component('x-input-service', () => import('../../modules/ApiPeruDev/Resources/assets/js/components/InputService.vue')); // apiperu - porque cambiar el input si tiene el mismo contenido?
// Vue.component('x-input-service', () => import('./components/InputService.vue'));



Vue.component('tenant-items-ecommerce-index', () => import('./views/tenant/items_ecommerce/index.vue'));
Vue.component('tenant-ecommerce-cart', () => import('./views/tenant/ecommerce/cart_dropdown.vue'));
Vue.component('tenant-tags-index', () => import('./views/tenant/tags/index.vue'));
Vue.component('tenant-promotions-index', () => import('./views/tenant/promotions/index.vue'));

Vue.component('tenant-item-sets-index', () => import('./views/tenant/item_sets/index.vue'));
Vue.component('tenant-person-types-index', () => import('./views/tenant/person_types/index.vue'));

Vue.component('tenant-orders-index', () => import('./views/tenant/orders/index.vue'));

//Cuenta
Vue.component('tenant-account-payment-index', () => import('./views/tenant/account/payment_index.vue'));
Vue.component('tenant-account-configuration-index', () => import('./views/tenant/account/configuration.vue'));

//auto update
Vue.component('system-update', () => import('./views/system/update/index.vue'));

//auto update
Vue.component('system-backup', () => import('./views/system/backup/index.vue'));

//culqi
Vue.component('system-configuration-culqi', () => import('./views/system/configuration/culqi.vue'))

//apk url
Vue.component('system-configuration-apk-url', () => import('./views/system/configuration/apk-url.vue'))

//token
Vue.component('system-configuration-token', () => import('./views/system/configuration/token_ruc_dni.vue'))

// php info
Vue.component('system-php-configuration', () => import('./views/system/configuration/php_info.vue'))
Vue.component('system-server-status', () => import('./views/system/configuration/server_status.vue'))

//Configuración global del login
Vue.component('system-login-settings', () => import('./views/system/configuration/login.vue'))

// Configuración del login
Vue.component('tenant-login-page', () => import('./views/tenant/login/index.vue'))

/** Modulo DIGEMID **/
Vue.component('tenant-digemid-index', () => import('../../modules/Digemid/Resources/assets/js/view/index.vue'));

/** Modulo Suscripcion Escolar**/
Vue.component('tenant-suscription-client-index', () => import('../../modules/Suscription/Resources/assets/js/clients/index.vue'));
Vue.component('tenant-suscription-plans-index', () => import('../../modules/Suscription/Resources/assets/js/plans/index.vue'));
Vue.component('tenant-suscription-payments-index', () => import('../../modules/Suscription/Resources/assets/js/payments/index.vue'));
Vue.component('data-table-payment-receipt', require('../js/components/DataTablePaymentReceipt.vue').default );
Vue.component('tenant-index-payment-receipt', require('../../modules/Suscription/Resources/assets/js/payment_receipt/index.vue').default );



/** Modulo Suscripcion **/
Vue.component('tenant-full-suscription-client-index', () => import('../../modules/FullSuscription/Resources/assets/js/clients/index.vue'));
Vue.component('tenant-full-suscription-plans-index', () => import('../../modules/FullSuscription/Resources/assets/js/plans/index.vue'));
Vue.component('tenant-full-suscription-payments-index', () => import('../../modules/FullSuscription/Resources/assets/js/payments/index.vue'));
Vue.component('tenant-full-suscription-index-payment-receipt', require('../../modules/FullSuscription/Resources/assets/js/payment_receipt/index.vue').default );


/** Prestamos Bancarios **/
Vue.component('tenant-bankloans-index', () => import('../../modules/Expense/Resources/assets/js/views/bank_loans/index.vue'));
Vue.component('tenant-bankloans-form', () => import('../../modules/Expense/Resources/assets/js/views/bank_loans/form.vue'));

/**Molino */
Vue.component('tenant-mill-index', () => import('../../modules/Production/Resources/assets/js/view/mill/index.vue'));
Vue.component('tenant-mill-form', () => import('../../modules/Production/Resources/assets/js/view/mill/form.vue'));
/** Maquinaria */
Vue.component('tenant-machine-index', () => import('../../modules/Production/Resources/assets/js/view/machine/index.vue'));
Vue.component('tenant-machine-type-index', () => import('../../modules/Production/Resources/assets/js/view/machine/index_type.vue'));
Vue.component('tenant-machine-form', () => import('../../modules/Production/Resources/assets/js/view/machine/form.vue'));
Vue.component('tenant-machine-type-form', () => import('../../modules/Production/Resources/assets/js/view/machine/form_type.vue'));

Vue.component('tenant-workers-index', () => import('../../modules/Production/Resources/assets/js/view/workers/index.vue'));

/** produccion */

Vue.component('tenant-production-index', () => import('../../modules/Production/Resources/assets/js/view/production/index.vue'));
Vue.component('tenant-production-form', () => import('../../modules/Production/Resources/assets/js/view/production/form.vue'));

Vue.component('tenant-packaging-index', () => import('../../modules/Production/Resources/assets/js/view/packaging/index.vue'));
Vue.component('tenant-packaging-form', () => import('../../modules/Production/Resources/assets/js/view/packaging/form.vue'));

/* Restaurante */
Vue.component('tenant-restaurant-list-items', () => import('../../modules/Restaurant/Resources/assets/js/views/items/index.vue'));
Vue.component('tenant-restaurant-promotions-index', () => import('../../modules/Restaurant/Resources/assets/js/views/promotions/index.vue'));
Vue.component('tenant-restaurant-orders-index', () => import('../../modules/Restaurant/Resources/assets/js/views/orders/index.vue'));
Vue.component('tenant-restaurant-cash-index', () => import('../../modules/Restaurant/Resources/assets/js/views/cash/index.vue'));
Vue.component('tenant-restaurant-cash-filter-pos', () => import('../../modules/Restaurant/Resources/assets/js/views/cash/filter-pos.vue'));
Vue.component('tenant-restaurant-configuration', () => import('../../modules/Restaurant/Resources/assets/js/views/configuration/index.vue'));


//Pagos
Vue.component('tenant-payment-configurations-index', () => import('@viewsModulePayment/payment_configurations/index.vue'));
Vue.component('tenant-public-payment-links-index', () => import('@viewsModulePayment/payment_links/public/index.vue'));
Vue.component('tenant-payment-links-index', () => import('@viewsModulePayment/payment_links/index.vue'));


import VueClipboard from 'vue-clipboard2'
Vue.use(VueClipboard)


import moment from 'moment';

Vue.mixin({
    filters: {
        toDecimals(number, decimal = 2) {
            return Number(number).toFixed(decimal);
        },
        DecimalText: function (number, decimal = 2) {
            return isNaN(parseFloat(number)) ? number : Number(number).toFixed(decimal);
        },
        toDate(date) {
            if (date) {
                return moment(date).format('DD/MM/YYYY');
            }
            return '';
        },
        toTime(time) {
            if (time) {
                if (time.length === 5) {
                    return moment(time + ':00', 'HH:mm:ss').format('HH:mm:ss');
                }
                return moment(time, 'HH:mm:ss').format('HH:mm:ss');
            }
            return '';
        },
        pad(value, fill = '', length = 3) {
            if (value) {
                return String(value).padStart(length, fill);
            }
            return value;
        }
    },
    methods: {
        axiosError(error) {
            const response = error.response;
            const status = response.status;
            if (status === 422) {
                this.errors = response.data
            }
            if (status === 500) {
                this.$message({
                    type: 'info',
                    message: response.data.message
                  });
            }
        }
    }
})
const app = new Vue({
    store: store,
    el: '#main-wrapper'
});
