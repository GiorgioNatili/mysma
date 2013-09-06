<?php
class ModelSettingExtension extends Model {
	function getExtensions($type) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "extension WHERE `type` = '" . $this->db->escape($type) . "'");
        if ($this->registry->has('tbManager')) {
            $tbManager = $this->registry->get('tbManager');
            if ($tbManager->getContext()->getArea() == 'catalog' && $tbManager->isThemeExtensionLoaded()) {
                $query->rows = array_merge($query->rows, $tbManager->getThemeModel()->getThemeModulesForOC());
            }
        }
		return $query->rows;
	}
}
?>