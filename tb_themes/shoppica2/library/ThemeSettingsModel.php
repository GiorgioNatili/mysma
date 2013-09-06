<?php

class TB_ThemeSettingsModel implements ArrayAccess
{
    /**
     * @var array
     */
    private $container = array();

    /**
     * @var TB_DbSettingsHelper
     */
    protected $dbSettingsHelper;

    /**
     * @var string
     */
    protected $settings_group;

    /**
     * @var int
     */
    protected $store_id;

	public function __construct(TB_DbSettingsHelper $dbSettingsHelper, TB_Context $context)
    {
		$this->dbSettingsHelper = $dbSettingsHelper;
        $this->settings_group   = $context->getSettingsGroup();
        $this->store_id         = $context->getStoreId();
	}

    /**
     * @param $scope
     * @return null|mixed
     */
    public function getScopeSettings($scope)
    {
        if (!isset($this->container[$scope])) {
            $this->container[$scope] = $this->dbSettingsHelper->getKey($scope, $this->store_id, $this->settings_group);
        }

        return $this->container[$scope];
    }

    public function setScopeSettings($scope, $settings)
    {
        $this->container[$scope] = $settings;
    }

    public function persistScopeSettings($scope)
    {
        $this->dbSettingsHelper->persistKey($scope, $this->store_id, $this->settings_group, $this[$scope]);
    }

    public function setAndPersistScopeSettings($scope, $settings)
    {
        $this->setScopeSettings($scope, $settings);
        $this->persistScopeSettings($scope);
    }

    public function deleteScopeSettings($scope)
    {
        $this->dbSettingsHelper->deleteKey($scope, $this->store_id, $this->settings_group);
        unset($this->container[$scope]);
    }

    public function __get($name)
    {
        return $this->offsetGet($name);
    }

    public function __set($name, $value)
    {
        $this->offsetSet($name, $value);
    }

    public function offsetSet($offset, $value)
    {
        $this->container[$offset] = $value;
    }

    public function offsetUnset($offset)
    {
        unset($this->container[$offset]);
    }

    public function offsetExists($offset)
    {
        if (isset($this->container[$offset])) {

            return true;
        }

        $result = $this->getScopeSettings($offset);

        return null !== $result;
    }

    /**
     * @param $offset
     * @return mixed|null
     */
    public function offsetGet($offset)
    {
        if (isset($this->container[$offset])) {

            return $this->container[$offset];
        }

        return $this->getScopeSettings($offset);
    }
}