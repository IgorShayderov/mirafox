{extends file="page_with_user_header.tpl"}

{* content *}
{block name="content"}
	{Helper::registerFooterJsFile("/js/pages/orders/orders.js"|cdnBaseUrl)}
	{Helper::registerFooterJsFile("/js/urlparams.js"|cdnBaseUrl)}

	{Helper::registerFooterJsFile("/js/dist/manage_orders.js"|cdnBaseUrl)}
	{Helper::printCssFile("/css/dist/manage_orders.css"|cdnBaseUrl)}

	{strip}
		<script type="text/javascript">
			const orders = {$orders|@json_encode nofilter};

			if (!window.dataStorage) {
				window.dataStorage = {};
			}

			window.dataStorage.orders = orders;
		</script>

		<div id="orders-vue"></div>
	{/strip}

	{include file="popup/order_change_name.tpl"}
	{include file="track/popup/inprogress_confirm.tpl"}
{/block}

{* Bootstrap modal *}
{Helper::registerFooterCssFile("/css/bootstrap.modal.css"|cdnBaseUrl)}

{Helper::registerFooterJsFile("/js/bootstrap.min.js"|cdnBaseUrl)}
{Helper::registerFooterJsFile("/js/bootstrap.modal.min.js"|cdnBaseUrl)}
{Helper::registerFooterJsFile("/js/components/youtube-thumbnail.js"|cdnBaseUrl)}

{* /content *}