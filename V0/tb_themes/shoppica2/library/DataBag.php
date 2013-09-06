<?php

class TB_DataBag implements ArrayAccess
{
    private $container    = array();
    private $callables    = array();

    public function __call($name, $arguments)
    {
        if (!isset($this->callables[$name])) {
            throw new Exception('This method is not added as callable: ' . $name);
        }

        return call_user_func_array($this->callables[$name], $arguments);
    }

    public function addCallable($callable, $synonym = null)
    {
        if (is_callable($callable, true, $name)) {
            if (!strpos($name, '::')) {
                throw new Exception('You must specify a class method when adding a callable ' . $name);
            }
            list(, $method_name) = explode('::', $name);
            if (null !== $synonym) {
                if (isset($this->callables[$synonym])) {
                    throw new Exception('This synonym has been already defined: ' . $synonym);
                }
                $this->callables[$synonym] = $callable;
            } else
            if (!isset($this->callables[$method_name])) {
                $this->callables[$method_name] = $callable;
            } else {
                throw new Exception('This callablle has been already defined: ' . $method_name);
            }
        } else {
            throw new Exception('You must specify a class method when adding a callable ' . $callable);
        }
    }

    public function addJavascriptVar($space, $var)
    {
        if (!strpos($space, '/')) {
            throw new Exception('You must specify a javascript registry space for the variable ' . $space);
        }

        list($section, $name) = explode('/', $space, 2);
        $this->container['javascript'][$section][$name] = $var;
    }

    public function __get($name)
    {
        return $this->offsetGet($name);
    }

    public function __set($name, $value)
    {
        $this->offsetSet($name, $value);
    }

    public function __isset($name)
    {
        return $this->offsetExists($name);
    }

    public function __unset($name)
    {
        $this->offsetUnset($name);
    }

    public function get($name)
    {
        return $this->offsetGet($name);
    }

    public function offsetSet($offset, $value)
    {
        if (is_null($offset)) {
            $this->container[] = $value;
        } else {
            $this->container[$offset] = $value;
        }
    }

    public function offsetExists($offset)
    {
        return isset($this->container[$offset]);
    }

    public function offsetUnset($offset)
    {
        unset($this->container[$offset]);
    }

    public function offsetGet($offset)
    {
        return isset($this->container[$offset]) ? $this->container[$offset] : null;
    }

    public function importVars(array $vars)
    {
        foreach ($vars as $key => $value) {
            $this[$key] = $value;
        }
    }

    public function exportVars()
    {
        return $this->container;
    }
}