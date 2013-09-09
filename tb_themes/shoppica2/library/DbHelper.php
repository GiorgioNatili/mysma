<?php
class TB_DbHelper
{
    /**
     * @var DB
     */
	protected $db;

    /**
     * @var string
     */
    protected $db_prefix;

	public function __construct($db, $db_prefix = '')
    {
		$this->db = $db;
        $this->db_prefix = $db_prefix;
	}

    /**
     * @param string $table_name
     * @param array $data
     * @return string
     */
    public function addRecord($table_name, array $data)
    {
        $table_name = $this->db_prefix . $table_name;

        $fields = array_keys($data);
        $values = array_values($data);

        foreach ($fields as $key => $field) {
            $fields[$key] = '`' . $field . '`';
            $values[$key] = $this->quote($values[$key]);
        }

        $fieldList = implode(', ', $fields);
        $valueList = implode(', ', $values);

        $sql = "INSERT INTO `$table_name` ($fieldList) VALUES ($valueList)";

        return $this->db->query($sql);
    }

    /**
     * @param string $table_name
     * @param array $data
     * @param null|string $where
     * @return string
     */
    public function updateRecord($table_name, array $data, $where = null)
    {
        $table_name = $this->db_prefix . $table_name;

        $fields = array_keys($data);
        $values = array_values($data);
        $tmp    = array();

        foreach ($fields as $key => $field) {
            $tmp[] = '`' . $field . '` = ' . $this->quote($values[$key]);
        }
        $fieldList = implode(', ', $tmp);

        if (is_array($where)) {
            $fields = array_keys($where);
            $values = array_values($where);
            $tmp    = array();
            foreach ($fields as $key => $field) {
                $tmp[] = '`' . $field . '` = ' . $this->quote($values[$key]);
            }
            $where = implode(' AND ', $tmp);
        }

        $sql = "UPDATE `$table_name` SET $fieldList";
        if (!empty($where)) {
            $sql .= ' WHERE ' . $where;
        }

        return $this->db->query($sql);
    }

    /**
     * @param string $table_name
     * @param string|array $where
     * @return string
     */
    public function deleteRecord($table_name, $where)
    {
        if (empty($where)) {
            return false;
        }

        $table_name = $this->db_prefix . $table_name;

        if (is_array($where)) {
            $fields = array_keys($where);
            $values = array_values($where);
            $tmp    = array();
            foreach ($fields as $key => $field) {
                $tmp[] = '`' . $field . '` = ' . $this->quote($values[$key]);
            }
            $where = implode(' AND ', $tmp);
        }

        $sql = "DELETE FROM `$table_name` WHERE $where";

        return $this->db->query($sql);
    }

    public function getFoundRows()
    {
        return $this->db->query('SELECT FOUND_ROWS() AS cnt');
    }

    public function quote($string)
    {
        return "'" . $this->db->escape($string) . "'";
    }

    public function getDb()
    {
        return $this->db;
    }

    public function getDbPrefix()
    {
        return $this->db_prefix;
    }
}