<?php

class ControllerFeedWebApi extends Controller {

	# Use print_r($json) instead json_encode($json)
	private $debug = false;

	public function categories() {
		$this->init();
		$this->load->model('catalog/category');
		$json = array('success' => true);

		# -- $_GET params ------------------------------
		
		if (isset($this->request->get['parent'])) {
			$parent = $this->request->get['parent'];
		} else {
			$parent = 0;
		}

		if (isset($this->request->get['level'])) {
			$level = $this->request->get['level'];
		} else {
			$level = 1;
		}

		# -- End $_GET params --------------------------

		/*
                 * $json['categories'] = $this->model_catalog_category->getCategoriesForAPI(array(
                    'filter_parent_id'  => $parent
                ));
                 */
                $json['categories'] = $this->getCategoriesTree($parent, $level);

		if ($this->debug) {
			echo '<pre>';
			print_r($json);
		} else {
			$this->response->setOutput(json_encode($json));
		}
	}

	public function category() {
		$this->init();
		$this->load->model('catalog/category');
		$this->load->model('tool/image');
		$this->load->model('catalog/product');

		$json = array('success' => true);

		# -- $_GET params ------------------------------
		
		if (isset($this->request->get['id'])) {
			$category_id = $this->request->get['id'];
		} else {
			$category_id = 0;
		}

		# -- End $_GET params --------------------------

		$category = $this->model_catalog_category->getCategoryForAPI($category_id);
		$category['categories'] = $this->getCategoriesTree($category['id']);
		$category['total_products'] = $this->model_catalog_product->getTotalProducts(array('filter_category_id' => $category_id));
                
                $json['category'] = $category;
		if ($this->debug) {
			echo '<pre>';
			print_r($json);
		} else {
			$this->response->setOutput(json_encode($json));
		}
	}

	private function __($needle, $haystack, $default = null) {
		return array_key_exists($needle, $haystack) ? $haystack[$needle] : $default;
	}


	public function products() {
		$this->init();
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
		$json = array('success' => true, 'products' => array());
		$filters = array();
		$get = $this->request->get;

		# -- $_GET params ------------------------------
		
		if ( $this->__('category',$get) !== null ) {
			$filters['filter_category_id'] = $this->request->get['category'];
		} 

		if ( $this->__('order',$get) !== null ) {
			$filters['order'] = $this->request->get['order'];
		} 
		if ( $this->__('sort',$get) !== null ) {
			$filters['sort'] = $this->request->get['sort'];
		} 

		if ( $this->__('limit',$get) !== null ) {
			$filters['limit'] = $this->request->get['limit'];
			$filters['start'] = $this->__('start', $get, 0);
		} 

		
                $products = $this->model_catalog_product->getProductsForAPI($filters);
		# -- End $_GET params --------------------------
               
                $json['products'] = $products;
		

		if ($this->debug) {
			echo '<pre>';
			print_r($json);
		} else {
			$this->response->setOutput(json_encode($json));
		}
	}

	public function product() {
		$this->init();
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
		$json = array('success' => true);

		# -- $_GET params ------------------------------
		
		if (isset($this->request->get['id'])) {
			$product_id = $this->request->get['id'];
		} else {
			$product_id = 0;
		}

		# -- End $_GET params --------------------------

		$product = $this->model_catalog_product->getProductForAPI($product_id);
                $json['product'] = $product;
		if ($this->debug) {
			echo '<pre>';
			print_r($json);
		} else {
			$this->response->setOutput(json_encode($json));
		}
	}


	/**
	 * Generation of category tree
	 * 
	 * @param  int    $parent  Prarent category id
	 * @param  int    $level   Depth level
	 * @return array           Tree
	 */
	private function getCategoriesTree($parent = 0, $level = 1) {
		$this->load->model('catalog/category');
		$this->load->model('tool/image');
                $this->load->model('catalog/product');
		
		$result = array();

		$categories = $this->model_catalog_category->getCategories($parent);
                //echo $parent.',';
                
		if ($categories && $level > 0) {
			$level--;

			foreach ($categories as $category) {

				/*
                                 * if ($category['image']) {
					$image = $this->model_tool_image->resize($category['image'], $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
				} else {
					$image = false;
				}
                                 */

				$result[] = array(
					'category_id'   => $category['category_id'],
					'parent_id'     => $category['parent_id'],
					'name'          => $category['name'],
					//'image'         => $image,
					//'href'          => $this->url->link('product/category', 'category_id=' . $category['category_id']),
					'categories'    => $this->getCategoriesTree($category['category_id'], $level),
                                        'total_products'    => $this->model_catalog_product->getTotalProducts(array(
                                            'filter_category_id'    => $category['category_id']
                                        ))
				);
			}

			return $result;
		}
	}

	/**
	 * 
	 */
	private function init() {

		$this->response->addHeader('Content-Type: application/json');

		if (!$this->config->get('web_api_status')) {
			$this->error(10, 'API is disabled');
		}

		if ($this->config->get('web_api_key') && (!isset($this->request->get['key']) || $this->request->get['key'] != $this->config->get('web_api_key'))) {
			$this->error(20, 'Invalid secret key');
		}
	}

	/**
	 * Error message responser
	 *
	 * @param string $message  Error message
	 */
	private function error($code = 0, $message = '') {

		# setOutput() is not called, set headers manually
		header('Content-Type: application/json');

		$json = array(
			'success'       => false,
			'code'          => $code,
			'message'       => $message
		);

		if ($this->debug) {
			echo '<pre>';
			print_r($json);
		} else {
			echo json_encode($json);
		}
		
		exit();
	}

}
