<?php

require_once TB_THEME_ROOT . '/library/ViewSlotEvent.php';

class TB_ViewSlot
{
    protected $openSlots = array();
    protected $events = array();

    /**
     * @var sfEventDispatcher
     */
    protected $eventDispatcher;

    public function __construct(sfEventDispatcher $dispatcher)
    {
        $this->eventDispatcher = $dispatcher;
    }

    public function __destruct()
    {
        if (count($this->openSlots) > 0) {
            ob_get_clean();
            trigger_error('You have unclosed slots : ' . var_export($this->openSlots, true), E_USER_ERROR);
            echo "\n<br /> Terminating sript execution.";
            exit();
        }
    }

    /**
     * Filters a variable that has been passed from the view.
     *
     * @param string $name The variable name
     * @param mixed $value
     * @param array $params Additional parameters that will be passed to the filter event
     *
     * @return mixed
     */
    public function filter($name, $value, array $params = array())
    {
        $event = new sfEvent($this, 'view_filter:' . $name, $params);
        $this->eventDispatcher->filter($event, $value);

        return $event->getReturnValue();
    }

    /**
     * Starts a new slot.
     *
     * This method starts an output buffer that will be closed and echoed when the stop() method is called.
     * Through the event you can insert content before and after the slot. With phpquery you can also modify the
     * content that has been captured within the slot.
     *
     * @param string $name  The slot name
     * @param array $params Additional parameters that will be passed to the event
     *
     * @return array
     *
     * @throws InvalidArgumentException if a slot with the same name is already started
     */
    public function start($name, array $params = array())
    {
        if (in_array($name, $this->openSlots)) {
            throw new InvalidArgumentException(sprintf('A slot named "%s" is already started.', $name));
        }

        $this->openSlots[] = $name;
        $this->events[$name] = new TB_ViewSlotEvent($this, 'view_slot:' . $name, $params);

        ob_start();
        ob_implicit_flush(0);
    }

    /**
     * Stops and outputs the slot's captured (and optionally modified) content.
     *
     * @throws LogicException if no slot has been started
     */
    public function stop()
    {
        if (!$this->openSlots) {
            throw new LogicException('No slot started.');
        }

        $name    = array_pop($this->openSlots);
        $content = ob_get_clean();
        $event   =  $this->events[$name];

        $event->setContent($content);

        $this->eventDispatcher->notify($event);

        echo $event->getAllContent();
        unset($this->events[$name]);
    }

    /**
     * Defines a view flag. Basically works like invoking start() and stop() consecutively.
     * Through the event you can insert content before and after the flag.
     *
     * @param string $name The flag name
     * @param array $params Additional parameters that will be passed to the event
     */
    public function flag($name, array $params = array())
    {
        $event = new TB_ViewSlotEvent($this, 'view_flag:' . $name, $params);
        $this->eventDispatcher->notify($event);
        echo $event->getAllContent();
    }
}