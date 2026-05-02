<?php

namespace SolusVMPlus;
class CaseInsensitiveArray implements \ArrayAccess, \Countable, \Iterator
{
	private $data = array();
	private $keys = array();

	public function __construct(array $initial = null)
	{
		if ($initial !== null) {
			foreach ($initial as $key => $value) {
				$this->offsetSet($key, $value);
			}
		}
	}

	public function offsetSet($offset, $value)
	{
		if ($offset === null) {
			$this->data[] = $value;
		} else {
			$offsetlower = strtolower($offset);
			$this->data[$offsetlower] = $value;
			$this->keys[$offsetlower] = $offset;
		}
	}

	public function offsetExists($offset)
	{
		return (bool)array_key_exists(strtolower($offset), $this->data);
	}

	public function offsetUnset($offset)
	{
		$offsetlower = strtolower($offset);
		unset($this->data[$offsetlower]);
		unset($this->keys[$offsetlower]);
	}

	public function offsetGet($offset)
	{
		$offsetlower = strtolower($offset);
		return isset($this->data[$offsetlower]) ? $this->data[$offsetlower] : null;
	}

	public function count()
	{
		return (int)count($this->data);
	}

	public function current()
	{
		return current($this->data);
	}

	public function next()
	{
		next($this->data);
	}

	public function key()
	{
		$key = key($this->data);
		return isset($this->keys[$key]) ? $this->keys[$key] : $key;
	}

	public function valid()
	{
		return (bool)!(key($this->data) === null);
	}

	public function rewind()
	{
		reset($this->data);
	}
}