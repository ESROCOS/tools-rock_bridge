#!/usr/bin/env python3

# H2020 ESROCOS Project
# Company: GMV Aerospace & Defence S.A.U.
# Licence: GPLv2

import os
from mako.template import Template
from mako.exceptions import text_error_template
import sys
from subprocess import call

from .ivData import IvData


def perror(msg):
	'''Print a message to stderr'''
	print(msg, file=sys.stderr)


def generate_orogen(tasteFunction, ivPath):
	# File paths
	scriptDir = os.path.dirname(os.path.realpath(__file__))
	orogenTemplate = os.path.join(scriptDir, 'templates', 'orogen.mako')

	outOrogenFile = os.path.join('output', tasteFunction+'.orogen')
	
	#Load iv.py
	ivObj = IvData(ivPath)
	
	#Check all interfaces are sporadic
	
	try:
		for iface in ivObj.list_interfaces(tasteFunction):
			if( len(ivObj.list_in_params(tasteFunction, iface)) + len(ivObj.list_out_params(tasteFunction, iface)) != 1):
				perror('ERROR] Each interface must have one parameter.')
				return False
	except:	
		perror('[ERROR] Each interface must have one parameter.')
		return False
	
		
	# Render templates
	try:
		template = Template(filename=orogenTemplate)
		outOrogen = template.render(iv=ivObj, tasteFunc=tasteFunction)
	except:
		perror('[ERROR] Error generating {}:'.format(outOrogenFile))
		return False 

	# Write file   
	try:
		if not os.path.exists(os.path.dirname(outOrogenFile)):
			os.makedirs(os.path.dirname(outOrogenFile))
		with open(outOrogenFile, 'w') as fd:
			fd.write(outOrogen)
	except Exception as err:
		perror('[ERROR] Error writing code to {}:\n{}'.format(outOrogenFile, err))
		return False
		
	return True

def generate_task_output(tasteFunction, ivPath):
	# File paths
	scriptDir = os.path.dirname(os.path.realpath(__file__))
	headerTemplate = os.path.join(scriptDir, 'templates', 'header.hpp.mako')
	srcTemplate = os.path.join(scriptDir, 'templates', 'source.cpp.mako')

	outHeaderFile = os.path.join('output/tasks', tasteFunction+'_task.hpp')
	outSrcFile = os.path.join('output/tasks', tasteFunction+'_task.cpp')

	#Load iv.py
	ivObj = IvData(ivPath)
			
	# Render templates
	try:
		template = Template(filename=headerTemplate)
		outHeader = template.render(iv=ivObj, tasteFunc=tasteFunction)
	except:
		perror('[ERROR] Error generating {}:'.format(headerTemplate))
		return False

	try:
		template = Template(filename=srcTemplate)
		outSrc = template.render(iv=ivObj, tasteFunc=tasteFunction)
	except:
		perror('[ERROR] Error generating {}:'.format(outSrcFile))
		return False
	
	
	# Write files
	try:
		if not os.path.exists(os.path.dirname(outHeaderFile)):
			os.makedirs(os.path.dirname(outHeaderFile))
		with open(outHeaderFile, 'w') as fd:
			fd.write(outHeader)
	except Exception as err:
		perror('[ERROR] Error writing code to {}:\n{}'.format(outHeaderFile, err))
		return False

	try:
		if not os.path.exists(os.path.dirname(outSrcFile)):
			os.makedirs(os.path.dirname(outSrcFile))
		with open(outSrcFile, 'w') as fd:
			fd.write(outSrc)
	except Exception as err:
		perror('[ERROR] Error writing code to {}:\n{}'.format(outSrcFile, err))
		return False

	return True
   
def generate_task_taste(tasteFunction, ivPath): 
	# File paths
	scriptDir = os.path.dirname(os.path.realpath(__file__))
	
	tasteTemplate = os.path.join(scriptDir, 'templates', 'taste.cc.mako')
	outTasteFile = os.path.join('output', tasteFunction+'.cc')

	#Load iv.py
	ivObj = IvData(ivPath)
			
	# Render templates
	try:
		template = Template(filename=tasteTemplate)
		outTaste = template.render(iv=ivObj, tasteFunc=tasteFunction)
	except:
		perror('[ERROR] Error generating {}:'.format(outTasteFile))
		return False 

	# Write file   
	try:
		if not os.path.exists(os.path.dirname(outTasteFile)):
			os.makedirs(os.path.dirname(outTasteFile))
		with open(outTasteFile, 'w') as fd:
			fd.write(outTaste)
	except Exception as err:
		perror('[ERROR] Error writing code to {}:\n{}'.format(outTasteFile, err))
		return False
		
	return True	
           



	
	
	
