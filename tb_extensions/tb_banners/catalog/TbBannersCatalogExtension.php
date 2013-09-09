<?php

class TbBanners_Catalog_Extension extends TB_CatalogExtension
{
    public function configure()
    {
        //$this->eventDispatcher->connect('core:onRouting', array($this, 'test'));
        //$this->eventDispatcher->connect('view_flag:product\product.related.each', array($this, 'testEach'));
        //$this->eventDispatcher->connect('view_filter:product\product.related', array($this, 'testFilter'));
        //$this->eventDispatcher->connect('view_flag:product\product.related', array($this, 'testQuery'));
        //$this->eventDispatcher->connect('view_slot:product\product.product_tags', array($this, 'testSlot'));
    }

    public function testSlot(TB_ViewSlotEvent $event)
    {
        var_dump($event['data']['tags']);
        $event->insertContentAfter('test content');
    }

    public function test(sfEvent $event)
    {
        $event->setReturnValue('information/information');

        return true;
    }

    public function testQuery(sfEvent $event)
    {
        $modifier = $event->getSubject();
        $modifier->insertContentAfter('<div>foo</div>');
        $pq = $modifier->getContentPhpQuery();
        $pq->find('div.price')->append('<div class="bar">BAR</div>');

        $modifier->setContent($pq);
    }

    public function testFilter(sfEvent $event, $arguments)
    {
        $params = $arguments;
        foreach ($params['products'] as $key => $product) {
            $params['products'][$key]['name'] = 'Oranges';
            $params['products'][$key]['price'] = 200;
        }

        return $params;
    }

    public function testEach(sfEvent $event)
    {
        $modifier = $event->getSubject();
        $params = $modifier->getParams();
        $pq = $modifier->getContentPhpQuery();
        $pq->find('div.image')->before('hataka');

        $modifier->setContent($pq);
    }
}