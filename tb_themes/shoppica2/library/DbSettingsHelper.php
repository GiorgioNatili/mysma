<?php

class TB_DbSettingsHelper
{
    /**
     * @var TB_DbHelper
     */
    protected $dbHelper;

    /**
     * @var DB
     */
    protected $db;

    public function __construct(TB_DbHelper $dbHelper)
    {
        $this->dbHelper = $dbHelper;
        $this->db = $dbHelper->getDb();
    }

    /**
     * @param string $key
     * @param int $store_id
     * @param string $group
     *
     * @return null|mixed
     */
    public function getKey($key, $store_id, $group = '')
    {
        $sql = 'SELECT * FROM ' .
                $this->dbHelper->getDbPrefix() . 'setting
                WHERE `store_id` = ' . (int) $store_id . ' AND
                      `key` = '      . $this->dbHelper->quote($key);
        if (!empty($group)) {
            $sql .= ' AND `group` = '    . $this->dbHelper->quote($group);
        }

        $result = $this->db->query($sql);

        if ($result->num_rows > 0) {
            if ($result->row['serialized'] == '1') {
                return unserialize($result->row['value']);
            } else {
                return $result->row['value'];
            }
        }

        return null;
    }

    public function deleteKey($key, $store_id, $group = '')
    {
        $where = array(
            'store_id' => $store_id,
            'key'      => $key
        );
        if (!empty($group)) {
            $where['group'] = $group;
        }

        $this->dbHelper->deleteRecord('setting', $where);
    }

    public function persistKey($key, $store_id, $group, $value)
    {
        if (null !== $this->getKey($key, $store_id, $group)) {
            $data = array(
                'value'      => is_array($value) ? serialize($value) : $value,
                'serialized' => is_array($value) ? 1 : 0
            );
            $where = array(
                'store_id'   => $store_id,
                'group'      => $group,
                'key'        => $key
            );
            $this->dbHelper->updateRecord('setting', $data, $where);
        } else {
            $data = array(
                'store_id'   => $store_id,
                'group'      => $group,
                'key'        => $key,
                'value'      => is_array($value) ? serialize($value) : $value,
                'serialized' => is_array($value) ? 1 : 0
            );

            $this->dbHelper->addRecord('setting', $data);
        }
    }

    public function getGroup($group, $store_id)
    {
        $sql = 'SELECT * FROM ' .
                $this->dbHelper->getDbPrefix() . 'setting
                WHERE `store_id` = ' . (int) $store_id . ' AND
                      `group` = '    . $this->dbHelper->quote($group);
        $result = $this->db->query($sql);

        $data = array();
        foreach ($result->rows as $row) {
            if ($row['serialized'] == '1') {
                $data[$row['key']] = unserialize($row['value']);
            } else {
                $data[$row['key']] = $row['value'];
            }
        }

        return $data;
    }

    public function persistGroup($group, $data, $store_id)
    {
        foreach ($data as $key => $value) {
            $this->persistKey($key, $store_id, $group, $value);
        }
    }
}