#!/usr/bin/env python3

#python3 script.py ~/esrocos_workspace/tools/rock_bridge/taste-example/camera-taste camera_rock_bridge


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
	
	print(orogenTemplate)
	print(outOrogenFile)


	#Load iv.py
	ivObj = IvData(ivPath)
	
	#Check all interfaces are sporadic
	'''
	try:
		if len(ivObj.list_interfaces(tasteFunction)) != (len(ivObj.list_sporadic_pi(tasteFunction)) + len(ivObj.list_sporadic_ri(tasteFunction))):
			perror('Error all interfaces must be sporadics')
			return False
	except:	
		perror('Error error, function not found')
		return False
	'''
		
	# Render templates
	try:
		template = Template(filename=orogenTemplate)
		outOrogen = template.render(iv=ivObj, tasteFunc=tasteFunction)
	except:
		perror('Error generating {}:'.format(outOrogenFile))
		raise 

	# Write file   
	try:
		if not os.path.exists(os.path.dirname(outOrogenFile)):
			os.makedirs(os.path.dirname(outOrogenFile))
		with open(outOrogenFile, 'w') as fd:
			fd.write(outOrogen)
	except Exception as err:
		perror('Error writing code to {}:\n{}'.format(outOrogenFile, err))
		return
		
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
		perror('Error generating {}:'.format(headerTemplate))
		raise

	try:
		template = Template(filename=srcTemplate)
		outSrc = template.render(iv=ivObj, tasteFunc=tasteFunction)
	except:
		perror('Error generating {}:'.format(outSrcFile))
		raise
	
	
	# Write files
	try:
		if not os.path.exists(os.path.dirname(outHeaderFile)):
			os.makedirs(os.path.dirname(outHeaderFile))
		with open(outHeaderFile, 'w') as fd:
			fd.write(outHeader)
	except Exception as err:
		perror('Error writing code to {}:\n{}'.format(outHeaderFile, err))
		return

	try:
		if not os.path.exists(os.path.dirname(outSrcFile)):
			os.makedirs(os.path.dirname(outSrcFile))
		with open(outSrcFile, 'w') as fd:
			fd.write(outSrc)
	except Exception as err:
		perror('Error writing code to {}:\n{}'.format(outSrcFile, err))
		return
   
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
		perror('Error generating {}:'.format(outTasteFile))
		raise 

	# Write file   
	try:
		if not os.path.exists(os.path.dirname(outTasteFile)):
			os.makedirs(os.path.dirname(outTasteFile))
		with open(outTasteFile, 'w') as fd:
			fd.write(outTaste)
	except Exception as err:
		perror('Error writing code to {}:\n{}'.format(outTasteFile, err))
		return
		
	return True	
           



	
	
	
