<?php

class TbBanners_Admin_Extension extends TB_AdminExtension
{
    public function configure()
    {
        $this->eventDispatcher->connect('view_flag:tb\theme.tabs.navigation', array($this, 'addTabNavigation'));
        $this->eventDispatcher->connect('view_flag:tb\theme.tabs.content', array($this, 'addTabContent'));
    }

    public function addTabNavigation(TB_ViewSlotEvent $event)
    {
        $event->insertContentAfter($this->fetchTemplate('tab_navigation'));
    }

    public function addTabContent(TB_ViewSlotEvent $event)
    {
        $event->insertContentAfter($this->fetchTemplate('tab_content_holder'));
    }
}