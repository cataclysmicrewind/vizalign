/**
 * Copyright (c) 2009 Digital Primates IT Consulting Group
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * @author     Michael Labriola 
 * @version    
 **/ 
package org.flexunit.runner {
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.*;
	
	import org.flexunit.IncludeFlexClasses;
	import org.flexunit.events.UnknownError;
	import org.flexunit.experimental.theories.Theories;
	import org.flexunit.internals.dependency.ExternalRunnerDependencyWatcher;
	import org.flexunit.runner.external.IExternalDependencyRunner;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.IAsyncStartupRunListener;
	import org.flexunit.runner.notification.IRunListener;
	import org.flexunit.runner.notification.IRunNotifier;
	import org.flexunit.runner.notification.RunListener;
	import org.flexunit.runner.notification.RunNotifier;
	import org.flexunit.runner.notification.async.AsyncListenerWatcher;
	import org.flexunit.runners.Parameterized;
	import org.flexunit.token.AsyncCoreStartupToken;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.utils.ClassNameUtil;
	import org.fluint.uiImpersonation.VisualTestEnvironmentBuilder;

	[Event(type="testsComplete", type="flash.events.Event")]
	[Event(type="runnerStart", type="flash.events.Event")]
	[Event(type="testsStopped", type="flash.events.Event")]

	/**  
	 * FlexUnit4 Version: 4.1.00<br/>
	 * 
	 * The <code>FlexUnitCore</code> is responsible for executing objects that implement an <code>IRequest</code>
	 * interface.  There are several ways that the <code>IRequest</code> can be provided to the 
	 * <code>FlexUnitCore</code>.  If you pass FlexUnit4’s core anything other than an <code>IRequest</code>, the 
	 * core uses these methods to generate a <code>Request</code> object before processing continues.<br/>
	 * 
	 * Ways that an <code>IRequest</code> can be provided to the <code>FlexUnitCore</code> are as follows:
	 * <ul>
	 * <li> A group of arguments of arguments can be provided to the <code>#run</code> method which will
	 * eventaully create an <code>IRequest</code>.</li>
	 * <li> A group of classes consisting of suites and test cases to run can be provided to the 
	 * <code>#runClasses()</code>  method to generate an <code>IRequest</code>.</li>
	 * <li> An <code>IRequest</code> can be passed directly to the <code>#runRequest()</code> method.
	 * <code>IRequest</code>s can be generated by calling static methods that create <code>IRequests</code>
	 * in the <code>Request</code> class.</li>
	 * </ul>
	 * <br/>
	 * Ultimately, FlexUnit4 runs one and only one request per run. So, if you pass it multiple classes, etc. 
	 * these are all wrapped in a single <code>Request</code> before execution begins.  Once the 
	 * <code>IRequest</code> has been provided to the <code>FlexUnitCore</code>, the test run will begin
	 * once all <code>IRunListener</code> are ready.
	 * <br/>
	 * In order to add an <code>IRunListener</code> to the test run, the <code>#addListener()</code> method must 
	 * called.  If one wishes to remove a listener from the test run, the <code>#removeListener()</code> method
	 * needs to be called with <code>IRunListener</code> to remove.
	 * <br/>
	 * Once the test run has finished execution, a <code>Result</code> will be obtained and the <code>IRunListener</code>s
	 * will be notified of the results of the test run.
	 * 
	 * @see org.flexunit.runner.Request
	 * @see org.flexunit.runner.Result
	 * @see org.flexunit.runner.notification.IRunListener
	 */

	public class FlexUnitCore extends EventDispatcher {
		// We have a toggle in the compiler arguments so that we can choose whether or not the flex classes should
		// be compiled into the FlexUnit swc.  For actionscript only projects we do not want to compile the
		// flex classes since it will cause errors.
		CONFIG::useFlexClasses {
			// This class imports all Flex classes.
			/**
			 * @private
			 */
			private var t1:IncludeFlexClasses;
		}
		
		/**
		 * @private
		 */
		private var notifier:IRunNotifier;
		
		
		private var runnerExternalDependencyWatcher:ExternalRunnerDependencyWatcher;
		
		/**
		 * @private
		 */
		private var asyncListenerWatcher:AsyncListenerWatcher;
		
		/**
		 * @private
		 */
		private var _visualDisplayRoot:DisplayObjectContainer;

		/**
		 * @private
		 */
		private var topLevelRunner:IRunner;
		/**
		 * @private
		 */
		private var runListener:RunListener;
		/**
		 * @private
		 */
		private static const RUN_LISTENER:String = "runListener";
		public static const TESTS_COMPLETE : String = "testsComplete";
		public static const TESTS_STOPPED : String = "testsStopped";
		public static const RUNNER_START : String = "runnerStart";
		public static const RUNNER_COMPLETE : String = "runnerComplete";

		//Just keep theories linked in until we decide how to deal with it
		/**
		 * @private
		 */
		private var theory:Theories;
		/**
		 * @private
		 */
		private var params:Parameterized;
		
		/**
		 * Returns the version number.
		 */
		public static function get version():String {
			return "4.1.0.0rc2";
		}
		

		public function get visualDisplayRoot():DisplayObjectContainer {
			return _visualDisplayRoot; 
		}
		
		public function set visualDisplayRoot( value:DisplayObjectContainer ):void {
			_visualDisplayRoot = value;

			//pass the stage along to the VisualEnvironmentBuilder.. 
			VisualTestEnvironmentBuilder.getInstance( value );
		}

		/**
		 * Requests that the FlexUnitCore stop execution of the test environment.
		 * As Flash Player is single threaded, we will only be able to stop execution after the currently running test completes
		 * and before the next one begins, so this will always have a margin of error.
		 */
		public function pleaseStop():void {
			
			if ( topLevelRunner ) {
				topLevelRunner.pleaseStop();
			}

			//dispatchEvent( new Event( TESTS_STOPPED ) );			
		}

		private function dealWithArgArray( ar:Array, foundClasses:Array, missingClasses:Array ):void {
			for ( var i:int=0; i<ar.length; i++ ) {
				try {
					if ( ar[ i ] is String ) {
						foundClasses.push( getDefinitionByName( ar[ i ] ) ); 
					} else if ( ar[ i ] is Array ) {
						dealWithArgArray( ar[ i ] as Array, foundClasses, missingClasses );
					} else if ( ar[ i ] is IRequest ) {
						foundClasses.push( ar[ i ] ); 
					} else if ( ar[ i ] is Class ) {
						foundClasses.push( ar[ i ] ); 
					} else if ( ar[ i ] is Object ) {
						//this is actually likely an instance.
						//eventually we intend to have more evolved support for
						//this, but, for right now, just try to make it a class
						var className:String = getQualifiedClassName( ar[ i ] );
						var definition:* = getDefinitionByName( className );
						foundClasses.push( definition );
					}
				}
				catch ( error:Error ) {
					//logger.error( "Cannot find class {0}", ar[i] ); 
					var desc:IDescription = Description.createSuiteDescription( ar[ i ] );
					var failure:Failure = new Failure( desc, error );
					missingClasses.push( failure );
				}
			}
		}

		/**
		 * Determines what classes can be found in the provided <code>args</code>.  If any classes 
		 * have been reported but are missing, those classes will be reported as failures in the returned
		 * <code>Result</code>.  The classes that are found in the arguments will be wrapped into a
		 * <code>Request</code>, and that <code>Request</code> will be used for the test run.
		 * 
		 * @param args The arguments are provided for the test run.
		 * @return void.
		 */
		public function run( ...args ):void {
			var foundClasses:Array = new Array();
			//Unlike JUnit, missing classes is probably unlikely here, but lets preserve the metaphor
			//just in case
			var missingClasses:Array = new Array();
			
			dealWithArgArray( args, foundClasses, missingClasses );

			runClasses.apply( this, foundClasses );
			
			//This is kind of fake
			//Need to tie this to the remaining result set
			var result:Result = new Result();
			for ( var i:int=0; i<missingClasses.length; i++ ) {
				result.failures.push( missingClasses[ i ] );
			}
		}

		/**
		 * Wraps the class arguments contained in <code>args</code> into a <code>Request</code>.
		 * The classes that are found in the arguments will be wrapped into a
		 * <code>Request</code>, and that <code>Request</code> will be used for the test run.
		 * 
		 * @param args The class arguments that are provided for the test run.
		 */
		public function runClasses( ...args ):void {
			//This is just an optimization for the case where we are passed an IRequest
			//Otherwise it goes through the trouble of re-wrapping it in a suite.
			//When that happens we end up with potential sorting and filtering issues
			if ( args && ( args.length == 1 ) && args[ 0 ] is IRequest ) {
				runRequest( args[ 0 ] );
			} else {
				runRequest( Request.classes.apply( this, args ) );
			}
		}
		
		/**
		 * Runs the classes contained in the <code>Request</code> using the <code>IRunner</code> of 
		 * the <code>Request</code>.  Feedback will be written while the tests
		 * are running and stack traces writes will be made for all failed tests after all tests 
		 * complete.
		 * 
		 * @param request The <code>Request</code> describing the <code>IRunner</code> to use for
		 * for the test run.
		 */
		public function runRequest( request:Request ):void {
			runRunner( request.iRunner )
		}
		
		/**
		 * Runs the tests contained in <code>IRunner</code> if all <code>IAsyncStartupRunListerners</code>
		 * are ready; otherwise, the the test run will begin once all listeners have reported that they
		 * are ready.<br/>
		 * 
		 * Once the test run begins, feedback will be written while the tests are running and stack traces 
		 * writes will be made for all failed tests after all tests complete.
		 * 
		 * @param runner The <code>IRunner</code> to use for this test run.
		 */
		public function runRunner( runner:IRunner ):void {

			//Record the top level runner. This is the active runner in case we need to
			//do something like stop the execution of the test run
			topLevelRunner = runner;

			if ( runner is IExternalDependencyRunner ) {
				( runner as IExternalDependencyRunner ).dependencyWatcher = runnerExternalDependencyWatcher; 
			}

			if ( runnerExternalDependencyWatcher.allDependenciesResolved && asyncListenerWatcher.allListenersReady ) {
				beginRunnerExecution( runner );
			} else {				
				if ( !asyncListenerWatcher.allListenersReady ) {
					//we need to wait until all listeners are ready (or failed) before we can continue
					var tokenListeners:AsyncCoreStartupToken = asyncListenerWatcher.startUpToken;
					tokenListeners.runner = runner;
					tokenListeners.addNotificationMethod( verifyRunnerCanBegin );
				}
				
				if ( !runnerExternalDependencyWatcher.allDependenciesResolved ) {
					var tokenRunners:AsyncCoreStartupToken = runnerExternalDependencyWatcher.token;
					tokenRunners.runner = runner;
					tokenRunners.addNotificationMethod( verifyRunnerCanBegin );
				} 
			}
		}
		
		protected function verifyRunnerCanBegin( runner:IRunner ):void {
			if ( runnerExternalDependencyWatcher.allDependenciesResolved && asyncListenerWatcher.allListenersReady ) {
				beginRunnerExecution( runner );
			}
		}
		/**
		 * Starts the execution of the <code>IRunner</code>.
		 */
		protected function beginRunnerExecution( runner:IRunner ):void {
			var result:Result = new Result();
			runListener = result.createListener();
			addFirstListener( runListener );

			var token:AsyncTestToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			token.addNotificationMethod( handleRunnerComplete );
			token[ RUN_LISTENER ] = runListener;

			dispatchEvent( new Event( RUNNER_START ) );

			try {
				notifier.fireTestRunStarted( runner.description );
				runner.run( notifier, token );
			}
			
			catch ( error:Error ) {
				//I think we need to further restrict the case where this is true
				notifier.fireTestAssumptionFailed( new Failure( runner.description, error ) );

				finishRun( runListener );
			}
		}
		
		/**
		 * All tests have finished execution.
		 */
		private function handleRunnerComplete( result:ChildResult ):void {
			var tokenRunListener:RunListener = result.token[ RUN_LISTENER ];

			//Cleanup the top level runner
			topLevelRunner = null;
			
			//Cleanup up runListener reference
			runListener = null;

			finishRun( tokenRunListener );
		}
		
		/**
		 * Notifies that the <code>runListener</code> that the test run has finished.
		 * 
		 * @param runListener The listern to notify about the test run finishing.
		 */
		private function finishRun( runListener:RunListener ):void {
			notifier.fireTestRunFinished( runListener.result );
			removeListener( runListener );
				
			//Consider making this a custom event and attaching the result set
			dispatchEvent( new Event( TESTS_COMPLETE ) );
		}

		/**
		 * Adds a generic listener for errors. In practice this is used to catch global
		 * errors to ensure that, if a developer does not properly code an async test
		 * using FlexUnit APIs, that the player is not stopped by a message dialog
		 * Receiving this top level error is *very* bad and causes an immediate stop.
		 * 
		 * @param listener the listener to add
		 * @see org.flexunit.runner.notification.RunListener
		 */
		public function addUncaughtErrorListener( loaderInfo:LoaderInfo ):void {
			//dereferencing this anonymously so we don't have problems with other
			//FP versions
		
			if(loaderInfo.hasOwnProperty("uncaughtErrorEvents"))
				IEventDispatcher(loaderInfo["uncaughtErrorEvents"]).addEventListener("uncaughtError", uncaughtErrorHandler);
		}
		
		private function uncaughtErrorHandler( event:Event ):void {
			//We received a top level error here... this is most likely because
			//someone screwed up an async call, however, even in that case
			//we have limited ways to figure out why. we need to stop all 
			//of the tests immediately.
			event.preventDefault();

			var unknownError:UnknownError = new UnknownError( event );
			var description:IDescription = Description.createTestDescription( UnknownError, "Uncaught Top Level Exception" );
			var failure:Failure = new Failure( description, unknownError );
			
			notifier.fireTestFailure( failure );
			notifier.fireTestRunFinished( runListener.result );

			//Kill all listeners so they get no further events
			notifier.removeAllListeners();

			//Issue the pleaseStop to make the runners stop execution
			pleaseStop();
		}
		
		/**
		 * Add a listener to be notified as the tests run.
		 * @param listener the listener to add
		 * @see org.flexunit.runner.notification.RunListener
		 */
		public function addListener( listener:IRunListener ):void {
			notifier.addListener( listener );
			if ( listener is IAsyncStartupRunListener ) {
				asyncListenerWatcher.watchListener( listener as IAsyncStartupRunListener );
			}
		}

		private function addFirstListener( listener:IRunListener ):void {
			notifier.addFirstListener( listener );
			if ( listener is IAsyncStartupRunListener ) {
				asyncListenerWatcher.watchListener( listener as IAsyncStartupRunListener );
			}
		}

		/**
		 * Remove a listener.
		 * @param listener the listener to remove
		 */
		public function removeListener( listener:IRunListener ):void {
			notifier.removeListener( listener );

			if ( listener is IAsyncStartupRunListener ) {
				asyncListenerWatcher.unwatchListener( listener as IAsyncStartupRunListener );
			}			
		}
		
		/**
		 * Create a new <code>FlexUnitCore</code> to run tests.
		 */
		public function FlexUnitCore() {
			notifier = new RunNotifier();

			runnerExternalDependencyWatcher = new ExternalRunnerDependencyWatcher();
			
			asyncListenerWatcher = new AsyncListenerWatcher( notifier, null );
		}
	}
}